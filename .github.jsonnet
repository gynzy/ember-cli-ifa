local util = import '.github/jsonnet/index.jsonnet';
local image = 'mirror.gcr.io/node:24';

util.workflowJavascriptPackage(
  repositories=['github', 'gynzy'],
  packageManager='pnpm',
  branch='main',
  isPublicFork=true,
  buildSteps=[],
  testJob=util.ghJob(
    'test',
    image=image,
    useCredentials=false,
    runsOn='ubuntu-latest',
    steps=[
      util.pnpm.checkoutAndPnpm(
        ref='${{ github.event.pull_request.head.sha }}',
        source='github',
      ),
      util.step('lint', 'pnpm run lint'),
    ],
  ),
)
