// Replace the endpoint below after deploying Terraform (see infrastructure output http_api_endpoint).
const CONTACT_API_URL = "REPLACE_WITH_API_GATEWAY_ENDPOINT/contact";

document.getElementById("contactForm").addEventListener("submit", async function (e) {
  e.preventDefault();

  const form = e.target;
  const data = {
    name: form.name.value,
    email: form.email.value,
    message: form.message.value,
  };

  try {
    const response = await fetch(CONTACT_API_URL, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data),
    });

    const result = await response.json();
    const statusEl = document.getElementById("statusMessage");

    if (response.ok) {
      statusEl.textContent = "Message sent successfully!";
      statusEl.style.color = "green";
      form.reset();
    } else {
      statusEl.textContent = "Error: " + (result.message || "Something went wrong.");
      statusEl.style.color = "red";
    }
  } catch (error) {
    console.error("Error:", error);
    const statusEl = document.getElementById("statusMessage");
    statusEl.textContent = "Network error. Please try again later.";
    statusEl.style.color = "red";
  }
});
