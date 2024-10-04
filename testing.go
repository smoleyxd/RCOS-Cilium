package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
)

type HelmRelease struct {
	ApiVersion string `yaml:"apiVersion"`
	Kind       string `yaml:"kind"`
	Metadata   struct {
		Name string `yaml:"name"`
	} `yaml:"metadata"`
	Spec struct {
		Values map[string]interface{} `yaml:"values"`
	} `yaml:"spec"`
}

func main() {
	testDir := "cilium-tests"
	err := os.MkdirAll(testDir, 0755)
	if err != nil {
		log.Fatalf("Failed to create test directory: %v", err)
	}
	// Run tests
	runTests(testDir)
}

func runTests(testDir string) {
	files, err := os.ReadDir(testDir)
	if err != nil {
		log.Fatalf("Error reading test directory: %v", err)
	}

	for _, file := range files {
		if filepath.Ext(file.Name()) == ".yaml" {
			fmt.Printf("Testing configuration: %s\n", file.Name())
			applyConfig(filepath.Join(testDir, file.Name()))
			runTest()
			// Add cleanup if necessary
		}
	}
}

func applyConfig(fileName string) {
	cmd := exec.Command("kubectl", "apply", "-f", fileName)
	output, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("Error applying configuration: %v\nOutput: %s", err, output)
	}
	fmt.Printf("Configuration applied: %s\n", fileName)
}

func runTest() {
	// Implement your test logic here
	fmt.Println("Running tests...")
	// Example: Check if Cilium pods are running
	cmd := exec.Command("kubectl", "get", "pods", "-n", "kube-system", "-l", "k8s-app=cilium")
	output, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("Error checking Cilium pods: %v\nOutput: %s", err, output)
	}
	fmt.Printf("Cilium pods status:\n%s\n", output)
}
