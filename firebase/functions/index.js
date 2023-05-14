const functions = require("firebase-functions");
const admin = require("firebase-admin");
const fetch = (...args) =>
  import("node-fetch").then(({default: fetch}) => fetch(...args));

admin.initializeApp();
const database = admin.firestore();
const _baseUrl = "https://api.openai.com/v1/completions";

// Usage of Secret Manager API in Google Cloud.
// See: https://firebase.google.com/docs/functions/config-env?hl=es-419#secret-manager
exports.getOpenAIPrompt = functions
    .runWith({secrets: ["OPENAI_TOKEN"]})
    .https.onRequest((req, res) => {
      const tokenId = req.headers.authorization;
      if (tokenId === undefined) {
        return res.status(401).send("User not authenticated");
      }
      return admin.auth().verifyIdToken(tokenId)
          .then(async (_) => {
            const words = req.query.words;
            if (words === undefined) return;
            const simplePrompt = words.length == 1 ? "simple" : "";
            const countPrompt = words.length == 1 ? "word" : "words";
            const concatWords = Array(words).join(", ");

            const response = await fetch(_baseUrl, {
              method: "post",
              body: JSON.stringify({
                model: "text-davinci-003",
                prompt: "Write a " + simplePrompt +
                    " japanese sentence that contains the " + countPrompt +
                    " " + concatWords,
                max_tokens: 64,
              }),
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer " + process.env.OPENAI_TOKEN,
              },
            });
            res.json(await response.json());
          })
          .catch((err) => res.status(401).send(err));
    });

exports.createUserInFirestore = functions.auth.user().onCreate(async (user) => {
  await database.collection("Users").doc(user.uid).set({"isPro": false});
});

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
