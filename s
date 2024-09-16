(function() {
    // Function to check missing security headers
    function checkSecurityHeaders() {
        fetch(window.location.href).then(response => {
            let headers = response.headers;

            // Check for missing common security headers
            if (!headers.get("X-Frame-Options")) {
                console.warn("Potential Clickjacking vulnerability: Missing X-Frame-Options header");
            }
            if (!headers.get("X-Content-Type-Options")) {
                console.warn("Potential MIME-sniffing vulnerability: Missing X-Content-Type-Options header");
            }
            if (!headers.get("Content-Security-Policy")) {
                console.warn("Potential XSS and injection vulnerabilities: Missing Content-Security-Policy header");
            }
            if (!headers.get("Strict-Transport-Security")) {
                console.warn("Potential Man-in-the-Middle attack vulnerability: Missing Strict-Transport-Security header (HSTS)");
            }
        }).catch(err => {
            console.error("Error fetching headers for security checks: ", err);
        });
    }

    // Function to test basic XSS reflection vulnerability
    function testXSSReflection() {
        let xssPayload = '<script>alert("XSS")</script>';
        let reflected = false;

        // Check in the page content
        if (document.body.innerHTML.includes(xssPayload)) {
            reflected = true;
            console.warn("Potential XSS vulnerability: XSS payload reflected in page content.");
        }

        // Check in URL (GET parameter reflection)
        if (window.location.href.includes(xssPayload)) {
            console.warn("Potential XSS vulnerability: XSS payload reflected in URL.");
        }

        if (!reflected) {
            console.log("No XSS payload reflected.");
        }
    }

    // Function to check for insecure form submissions (non-HTTPS or no CSRF protection)
    function checkInsecureForms() {
        let forms = document.forms;
        for (let form of forms) {
            if (!form.action.startsWith('https')) {
                console.warn(`Insecure form submission: Form with action ${form.action} is using HTTP, not HTTPS.`);
            }

            // Check for anti-CSRF token (basic heuristic: check if there's any hidden input named token or csrf)
            let csrfToken = false;
            for (let input of form.elements) {
                if (input.type === "hidden" && (input.name.toLowerCase().includes("csrf") || input.name.toLowerCase().includes("token"))) {
                    csrfToken = true;
                }
            }

            if (!csrfToken) {
                console.warn(`Potential CSRF vulnerability: Form with action ${form.action} does not appear to have CSRF protection.`);
            }
        }
    }

    // Function to check for missing input validation on forms
    function checkFormInputValidation() {
        let forms = document.forms;
        for (let form of forms) {
            for (let input of form.elements) {
                if (input.type === "text" && !input.hasAttribute("required")) {
                    console.warn(`Potential input validation issue: Input field "${input.name}" in form ${form.action} does not have validation.`);
                }
            }
        }
    }

    // Function to check for possible open redirects
    function checkOpenRedirects() {
        let links = document.querySelectorAll("a[href^='http']");
        links.forEach(link => {
            if (link.href.includes("redirect=") || link.href.includes("url=")) {
                console.warn(`Potential Open Redirect vulnerability: Link with URL parameter ${link.href}`);
            }
        });
    }

    // Run vulnerability checks
    function runVulnerabilityChecks() {
        console.log("Running passive vulnerability checks...");
        
        // Check for security headers
        checkSecurityHeaders();

        // Test for XSS reflection
        testXSSReflection();

        // Check forms for insecure submission or missing CSRF tokens
        checkInsecureForms();

        // Check form inputs for missing validation
        checkFormInputValidation();

        // Check for open redirects
        checkOpenRedirects();
    }

    // Run the checks when the page is loaded
    window.onload = runVulnerabilityChecks;
})();
