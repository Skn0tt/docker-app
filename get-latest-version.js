const https = require('https');

const getContent = function(host, path) {
  return new Promise((resolve, reject) => {
    const request = https.get({
      headers: {
        "User-Agent": "Node"
      },
      host,
      path
    }, (response) => {
      const body = [];
      response.on('data', (chunk) => body.push(chunk));
      response.on('end', () => resolve(body.join('')));
    });
    request.on('error', (err) => reject(err))
  });
};

(async () => {
  const res = await getContent("api.github.com", "/repos/docker/app/releases");
  const json = JSON.parse(res);
  const newest = json[0];
  const newestVersion = newest.tag_name;
  console.log(newestVersion);  
})()
