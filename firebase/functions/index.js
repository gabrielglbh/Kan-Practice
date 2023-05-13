const functions = require("firebase-functions");
const fetch = (...args) =>
  import("node-fetch").then(({ default: fetch }) => fetch(...args));

const _baseUrl = "https://api.openai.com/v1/completions";

// Usage of Secret Manager API in Google Cloud.
// See: https://firebase.google.com/docs/functions/config-env?hl=es-419#secret-manager
exports.getOpenAIPrompt = functions
  .runWith({ secrets: ["OPENAI_TOKEN"] })
  .https.onRequest(async (req, res) => {
    const words = req.query.words;
    if (words === undefined) return;
    const simplePrompt = words.length == 1 ? "simple" : "";
    const countPrompt = words.length == 1 ? "word" : "words";
    const concatWords = Array(words).join(", ");

    const response = await fetch(_baseUrl, {
      method: "post",
      body: JSON.stringify({
        model: "text-davinci-003",
        prompt:
          "Write a " +
          simplePrompt +
          " japanese sentence that contains the " +
          countPrompt +
          " " +
          concatWords,
        max_tokens: 64,
      }),
      headers: {
        "Content-Type": "application/json",
        Authorization: "Bearer " + process.env.OPENAI_TOKEN,
      },
    });
    res.json(await response.json());
  });
