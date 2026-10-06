async function loadVersion() {
  const status = document.querySelector("#metadata-status");

  try {
    const response = await fetch("/version.json", {
      headers: { accept: "application/json" }
    });

    if (!response.ok) {
      throw new Error(`Version request returned ${response.status}`);
    }

    const version = await response.json();
    document.querySelector("#app-name").textContent = version.app;
    document.querySelector("#app-version").textContent = version.version;
    document.querySelector("#app-pattern").textContent = version.pattern;
    document.querySelector("#deployment-marker").textContent =
      version.deploymentMarker;
    status.textContent = "Version metadata loaded successfully.";
    status.dataset.state = "success";
  } catch (error) {
    status.textContent = `Unable to load version metadata: ${error.message}`;
    status.dataset.state = "error";
  }
}

loadVersion();
