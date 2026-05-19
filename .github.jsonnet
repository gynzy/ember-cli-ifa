local util = import '.github/jsonnet/index.jsonnet';
local image = 'node:24';

util.workflowJavascriptPackage(
  repositories=['github'],
  packageManager='pnpm',
  branch='main',
  isPublicFork=true,
  buildSteps=[],
  testJob=util.ghJob(
    'test',
    image=image,
    runsOn='ubuntu-latest',
    useCredentials=false,
    steps=[
      util.pnpm.checkoutAndPnpm(
        ref='${{ github.event.pull_request.head.sha }}',
        source='github',
      ),
      util.step('lint', 'pnpm run lint'),
      util.step('test', 'pnpm run test'),
    ],
  ),
)
