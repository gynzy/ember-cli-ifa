local util = import '.github/jsonnet/index.jsonnet';
local image = 'europe-docker.pkg.dev/unicorn-985/private-images/docker-images_node24-with-libnss:v1';

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
