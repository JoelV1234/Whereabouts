// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
const { onCall, HttpsError} = require("firebase-functions/v2/https");
// The Firebase Admin SDK to access Firestore.
const {initializeApp} = require("firebase-admin/app");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");

initializeApp();

let firestore = getFirestore();

//basic collections
const getUserCol = (uid) => firestore.collection('users').doc(uid);
const getNotifCol = (uid) => getUserCol(uid).collection('notifications');
const getGroupCol = (group) => firestore.collection('groups').doc(group);
const getPublicUser = (uid) => getUserCol(uid).collection('access').doc('public');
const getUserGroups = (uid) => getUserCol(uid).collection('groups').doc('groups');

const getAllPeers = async (user, transaction) => {
    let groups = (await transaction.get(getUserGroups(user))).data();
    let peers = [];
    for (const key in groups) {
        let members = (await transaction.get(getGroupCol(key))).data().members;
        peers.push(...Object.keys(members));
    }
    console.log(peers);
    return peers;
}

const isNotBlocked = async (me, acessUser) => {
    let blockedList = (await getUserCol(acessUser).get()).data().blocked;
    if (me in blockedList) { 
        throw new HttpsError('permission-denied', 'User has blocked you');}
    return true;
}
const updateMemberBoth = (user, group, value, batch) => {
    batch.update(getUserGroups(user), {[group] : value});
    batch.update(getGroupCol(group), {[`members.${user}`] : value});
}

const updateInviteBoth = (user, group, value, batch) => {
    batch.update(getNotifCol(user).doc('invites'), {[group] : value});
    batch.update(getGroupCol(group), {[`invites.${user}`] : value});
}

async function  isGroupOwner(group, uid) {
   let groupDoc = (await firestore.collection('groups').doc(group).get()).data();
   console.log(groupDoc);
   return groupDoc.owner == uid;
}

// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
exports.tester = onCall(async (request) => {
    // Grab the text parameter.
    // Push the new message into Firestore using the Firebase Admin SDK.
    // Send back a message that we've successfully written the message
    return "yess";
});

exports.createNewUser = onCall(async (request) => {
    let user = request.auth.token;

    if (request.data.username == null) {
        throw new HttpsError("invalid-argument" , `invalidate input ${request.data.username}`);}
    if (user.email_verified != true) {
        throw new HttpsError("permission-denied","Email not verified");} 
    let userNames = await firestore.collectionGroup('access').where(
        'username', '==', request.data.username).get();
    if (userNames.docs.length > 0) {
        throw new HttpsError("already-exists","Username already esists");} 


    let group_doc = {
        'email': user.email,
        'location': '0:0',
        'blocked' : {},
    };
    let public_doc = {
        'uid' : user.uid,
        'pictureurl' : user.picture ?? 'https://firebasestorage.googleapis.com/v0/b/location-sharing-app-c1719.firebasestorage.app/o/profile_pics%2Fdefault_pic.png?alt=media&token=f1746117-f55d-4bdf-91c7-4fdd055abc5b',
        'username' :  request.data.username
    };
    let batch = firestore.batch();
    batch.set(getUserCol(user.uid), group_doc);
    batch.set(getPublicUser(user.uid), public_doc);
    batch.set(getUserGroups(user.uid), {});
    batch.set(getNotifCol(user.uid).doc('invites'), {});
    batch.set(getNotifCol(user.uid).doc('read'), {});
    batch.set(getNotifCol(user.uid).doc('alerts'), {});
    batch.set(firestore.collection(`users/${user.uid}/location_data`).
    doc('location'), {});
    await batch.commit();
    return true;
});


//TODO: MAYBE EDIT GROUP NAME
exports.createGroup = onCall(async (request) => {
    let user = request.auth.token;
    let grpDoc = firestore.collection('groups').doc();
    let batch = firestore.batch();
    batch.set(grpDoc,  {
        'owner' : user.uid,
        'name' : request.data.name,
        'members' : {},
        'creationdate' : Date.now()
    });
    updateMemberBoth(user.uid, grpDoc.id, {'member' : true}, batch);
    await batch.commit();
    return {groupID : grpDoc.id}
});

exports.changDisplayName = onCall(async (request) => {
    await getPublicUser(request.auth.uid).update({
        'displayname' : request.data.name
    });
    return true;
});

exports.changeGroupName = onCall(async (request) => {
    let data = request.data;
    let user = request.auth.token;
    let isOwner = await isGroupOwner(data.group, user.uid);
    if (isOwner) {
        await getGroupCol(data.group).update({'name' : data.name}); 
        return true       
    }
    throw new HttpsError('permission-denied', "you do not have acces to this group");
});

exports.createPublicGroup = onCall(async (request) => {
    let data = request.data;
    let user = request.auth.token;
    let isOwner = await isGroupOwner(data.group, user.uid);
    if (isOwner) {
        let groupNames = (await firestore.collection('groups').where(
            'publicId', '==', data.publicId).get())
        if (groupNames.docs.length > 0) {
            throw new HttpsError("already-exists","Group name already esists");
        } else {
            getGroupCol(data.group).update({'publicId' :  data.publicId});
            return true;
        }
    }
    throw new HttpsError('permission-denied', "you do not have acces to this group");
});

exports.sendInvite = onCall(async (request) => {
    let user = request.auth.token;
    let data = request.data;
    let isOwner = await isGroupOwner(data.group, user.uid);
    let batch = firestore.batch();
    try {
        for (const index in data.users) {
            let invitee = data.users[index];
            if (isOwner && invitee != user.uid) {
                updateMemberBoth(invitee, data.group, {
                    'member' : false,
                    'uid' : crypto.randomUUID(),
                    'sender' : user.uid,
                    'type' : 'invite',
                    'sent' : Date.now(),
                }, batch);
            }
        }
        await batch.commit();
    } catch (error) {
        throw new HttpsError('aborted', error);
    }
    return true;
});

//TODO: make this into a transaction for atomicity
exports.addToGroup = onCall(async (request) => {
    let user = request.auth.token;
    let data = request.data;
    try {
        await firestore.runTransaction(async (transaction) => {
            let groupDod = (await transaction.get(getUserGroups(user.uid))).data();
            if (data.group in groupDod) {
                transaction.update(getGroupCol(data.group), {[`members.${user.uid}`] : {'member' : true}});
                transaction.update(getUserGroups(user.uid), {[data.group] : {'member' : true}});
            }
        });
        return true;
    } catch (error) {
        throw new HttpsError('aborted', error);

    }
});

exports.removeMember = onCall(async (request) => {
    let user = request.auth.token;
    let data = request.data;
    let isGrpOwner = await isGroupOwner(data.group, user.uid);
    let deleteSelf = isGrpOwner && data.user == user.uid;   
    let batch = firestore.batch();
    try {
        if ((isGrpOwner || user.uid == data.user) && !deleteSelf) {
            updateMemberBoth(data.user, data.group, FieldValue.delete(), batch);
            await batch.commit();
        }
    } catch (error) {
        throw new HttpsError('aborted', error.stack);
    }
    return true;
});

exports.sendAlert = onCall(async (request) => {
    let user = request.auth.token;
    let data = request.data;
    try {
        await firestore.runTransaction(async (transaction) => {
            let peers = await getAllPeers(user.uid, transaction);
            let payload = {
                [crypto.randomUUID()] : {
                    'type': 'user-alert',
                    'info' : {
                        'name' : data.name,
                        'location' : data.location,
                        'uid' : user.uid,
                        'contact' : data.contact,
                        'message' : data.message,
                    },
                    'updated' : Date.now()
                }
            };
            for (const peer of peers) {
                if(peer != user.uid) {
                    transaction.update(getNotifCol(peer).doc("alerts"), payload);
                }
            }
            transaction.update(getNotifCol(user.uid).doc("read"), payload);

        });
    } catch (error) {
        throw new HttpsError('aborted', error);
    }
});

exports.deleteGroup = onCall(async (request) => {
    let user = request.auth.token;
    let data = request.data;
    let groupOwner = await isGroupOwner(data.group, user.uid);
    let members = (await getGroupCol(data.group).get()).data().members;
    let clearedAll = Object.keys(members) == user.uid
    let batch = firestore.batch();
    try {
        if (groupOwner && clearedAll) {        
            updateMemberBoth(user.uid, data.group, FieldValue.delete(), batch);
            batch.delete(getGroupCol(data.group));
            await batch.commit();
            return true;
        }
    } catch (error) {
        throw new HttpsError('aborted', error);
    }
    throw new HttpsError('aborted', "cannot perform operation");
});

exports.seenAlert = onCall(async (request)  => {
    let user = request.auth.token;
    try {
        await firestore.runTransaction(async (transaction) => {
            let alertDoc = getNotifCol(user.uid).doc("alerts");
            let notifs = (await transaction.get(alertDoc)).data();
            transaction.set(alertDoc, {});
            transaction.update(getNotifCol(user.uid).doc("read"), notifs);
        });
    } catch (error) {
        throw new HttpsError('aborted', error);
    }
});
