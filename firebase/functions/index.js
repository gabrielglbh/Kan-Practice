const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const database = admin.firestore();

exports.removeBackup = functions.auth.user().onDelete(async (user) => {
  try {
    let writes = 0;

    let batch = database.batch();
    const wordSnapshot = await database.collection("BackUps")
        .doc(user.uid).collection("Kanji").get();
    const grammarSnapshot = await database.collection("BackUps")
        .doc(user.uid).collection("Grammar").get();
    const listsSnapshot = await database.collection("BackUps")
        .doc(user.uid).collection("Lists").get();
    const foldersSnapshot = await database.collection("BackUps")
        .doc(user.uid).collection("Folders").get();
    const testDataSnapshot = await database.collection("BackUps")
        .doc(user.uid).collection("Tests").get();
    const testSpecDataSnapshot = await database.collection("BackUps")
        .doc(user.uid).collection("TestsSpecs").get();
    const alterTestSpecDataSnapshot = await database.collection("BackUps")
        .doc(user.uid).collection("AlterTestsSpecs").get();
    const relFolderKanListSnapshot = await database.collection("BackUps")
        .doc(user.uid).collection("RelationsFK").get();

    if (wordSnapshot.size > 0) {
      for (let i = 0; i < wordSnapshot.length; i++) {
        batch.delete(database.collection("BackUps")
            .doc(user.uid).collection("Kanji")
            .doc(String(wordSnapshot.docs[i].get("word"))));
        writes++;
        if ((writes + 1) % 500 == 0) {
          await batch.commit();
          batch = database.batch();
        }
      }
    }

    if (grammarSnapshot.size > 0) {
      for (let i = 0; i < grammarSnapshot.length; i++) {
        batch.delete(database.collection("BackUps")
            .doc(user.uid).collection("Grammar")
            .doc(String(grammarSnapshot.docs[i].get("name"))));
        writes++;
        if ((writes + 1) % 500 == 0) {
          await batch.commit();
          batch = database.batch();
        }
      }
    }

    if (listsSnapshot.size > 0) {
      for (let i = 0; i < listsSnapshot.length; i++) {
        batch.delete(database.collection("BackUps")
            .doc(user.uid).collection("Lists")
            .doc(String(listsSnapshot.docs[i].get("name"))));
        writes++;
        if ((writes + 1) % 500 == 0) {
          await batch.commit();
          batch = database.batch();
        }
      }
    }

    if (foldersSnapshot.size > 0) {
      for (let i = 0; i < foldersSnapshot.length; i++) {
        batch.delete(database.collection("BackUps")
            .doc(user.uid).collection("Folders")
            .doc(String(foldersSnapshot.docs[i].get("folder"))));
        writes++;
        if ((writes + 1) % 500 == 0) {
          await batch.commit();
          batch = database.batch();
        }
      }
    }

    if (testDataSnapshot.size > 0) {
      for (let i = 0; i < testDataSnapshot.length; i++) {
        batch.delete(database.collection("BackUps")
            .doc(user.uid).collection("Tests")
            .doc(String(testDataSnapshot.docs[i].get("statsId"))));
        writes++;
        if ((writes + 1) % 500 == 0) {
          await batch.commit();
          batch = database.batch();
        }
      }
    }

    if (relFolderKanListSnapshot.size > 0) {
      for (let i = 0; i < relFolderKanListSnapshot.length; i++) {
        batch.delete(database.collection("BackUps")
            .doc(user.uid).collection("RelationsFK")
            .doc(String(i)));
        writes++;
        if ((writes + 1) % 500 == 0) {
          await batch.commit();
          batch = database.batch();
        }
      }
    }

    if (testSpecDataSnapshot.size > 0) {
      for (let i = 0; i < testSpecDataSnapshot.length; i++) {
        batch.delete(database.collection("BackUps")
            .doc(user.uid).collection("TestsSpecs")
            .doc(String(testSpecDataSnapshot.docs[i].get("id"))));
        writes++;
        if ((writes + 1) % 500 == 0) {
          await batch.commit();
          batch = database.batch();
        }
      }
    }

    if (alterTestSpecDataSnapshot.size > 0) {
      for (let i = 0; i < alterTestSpecDataSnapshot.length; i++) {
        batch.delete(database.collection("BackUps")
            .doc(user.uid).collection("AlterTestsSpecs")
            .doc(String(alterTestSpecDataSnapshot.docs[i].get("id"))));
        writes++;
        if ((writes + 1) % 500 == 0) {
          await batch.commit();
          batch = database.batch();
        }
      }
    }

    batch.delete(database.collection("BackUps").doc(user.uid));
    writes++;
    if ((writes + 1) % 500 == 0) {
      await batch.commit();
      batch = database.batch();
    }
  } catch (err) {
    return;
  }
});
