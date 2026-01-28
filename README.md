# Google Kubernetes Deployment Example

[![Deploy](https://github.com/IanKnighton/ideal-garbanzo/actions/workflows/deploy.yml/badge.svg)](https://github.com/IanKnighton/ideal-garbanzo/actions/workflows/deploy.yml)

I failed a technical assessment pretty miserably, so I wanted to make sure it never happened again. Okay, well, **never** is a strong word, but at least I now have my own reference point on how to make this all work.

## What this does:

1. Creates a Kubernetes Cluster, Artifact Registry, Workload Identity Provider, and a Kubernetes Deployment. This should be all of the resources needed to setup a GitHub Actions Workflow that will deploy an image to the Kubernetes Cluster.
2. Has a basic deployment workflow that runs some validation test, outputs the plan to a pull request, pushes the docker image to the artifact registry, and then applies the changes to the cluster.
3. Has a basic, containerized Go application that says hello with some style. It's nothing super fancy, but it lets you know it's working.

## What this does not:

- Account for any permissions you may need in your own environment to make this work. As always, one should push for LUA, but you'll need to make those decisions based on what is best for your environment. The built in permissions are pretty open, but there may be more that you need or don't based on your environment.
- Add the WIP secrets to GitHub. You _can_ do this via Terraform, but it can be a little tricky in the pipeline so I removed that logic. It was a fun example, but it was brittle in a way I didn't like. The values you need can be found in the outputs from the `google_wif_service_account`.

## How you can use it:

Take from it what you can, share the information where you can, and do the best you can. That's really all we can ask for from anyone.
