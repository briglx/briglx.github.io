---
layout: post
current: post
navigation: True
class: post-template
subclass: 'post'
author: brig
title: "Checks on GitHub Pull Requests"
date: "2024-07-03"
tags:
  - "github"
---

I'm late to the party because I just discovered the answer to something I was curious about every time I would submit a pull request for one of the projects I contribute to. 

When I submit the pr, GitHub runs a series of checks and I just learn this can be done with the (GitHub `REST API endpoint for Checks`)[https://docs.github.com/en/rest/checks?apiVersion=2022-11-28].

The basic idea is to:

* Create a webhook to be called when you submit a pr
* Create a custom app that will run the checks and receive the call from GitHub via the webhook
* Call the GitHub API to report the results of the checks

So simple, yet so powerful. I'm excited to try this out on my next project.

```javascript
# Custom App that will receive webhook call and publish results of checks to GitHub
app.post('/webhooks', (req, res) => {
  const event = req.headers['x-github-event'];
  const payload = req.body;

  if (event === 'pull_request' && payload.action === 'opened') {
    handlePullRequest(payload);
  }

  res.status(200).send('Event received');
});

function handlePullRequest(payload) {
  getInstallationAccessToken(installationId, token).then(accessToken => {
    // Do something with the access token, like adding a comment to the pull request
    const comment = {
      state: 'success',
      target_url: 'https://example.com/build/status',
      description: 'The build succeeded!',
      context: 'continuous-integration/example',
    };
    axios.post(
      `https://api.github.com/repos/${repoOwner}/${repoName}/status/${sha}`,
      comment,
      {
        headers: {
          Authorization: `Bearer ${accessToken}`,
          Accept: 'application/vnd.github.v3+json'
        }
      }
    );
  });
}
```

## References
* https://docs.github.com/en/apps/creating-github-apps/writing-code-for-a-github-app/building-ci-checks-with-a-github-app
* Commit Status https://docs.github.com/en/rest/commits/statuses?apiVersion=2022-11-28#create-a-commit-status