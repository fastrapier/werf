// +build integration

package guides_test

import (
	"fmt"

	. "github.com/onsi/ginkgo"

	"github.com/flant/werf/integration/utils"
	utilsDocker "github.com/flant/werf/integration/utils/docker"
)

var _ = Describe("Guide/Advanced build/Mounts", func() {
	var testDirPath string
	var testName = "mounts"

	AfterEach(func() {
		utils.RunCommand(
			testDirPath,
			werfBinPath,
			"stages", "purge", "-s", ":local", "--force",
		)
	})

	It("application should be built and checked", func() {
		testDirPath = tmpPath(testName)

		utils.CopyIn(fixturePath(testName), testDirPath)

		utils.RunCommand(
			testDirPath,
			werfBinPath,
			"build", "-s", ":local",
		)

		containerHostPort := utils.GetFreeTCPHostPort()
		containerName := fmt.Sprintf("go_booking_mounts_%s", utils.GetRandomString(10))
		utils.RunCommand(
			testDirPath,
			werfBinPath,
			"run", "-s", ":local", "--docker-options", fmt.Sprintf("-d -p %d:9000 --name %s", containerHostPort, containerName), "go-booking", "--", "/app/run.sh",
		)
		defer func() { utilsDocker.ContainerStopAndRemove(containerName) }()

		url := fmt.Sprintf("http://localhost:%d", containerHostPort)
		waitTillHostReadyAndCheckResponseBody(
			url,
			utils.DefaultWaitTillHostReadyToRespondMaxAttempts,
			"revel framework booking demo",
		)
	})
})
