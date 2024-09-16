
(function() {
    // Helper function to remove the Cookie header from Headers object
    function removeCookieHeader(headers) {
        // If there's a Cookie header, remove it
        if (headers.has('Cookie')) {
            headers.delete('Cookie');
        }
    }

    // Intercepting the fetch API
    const originalFetch = window.fetch;
    window.fetch = async function(resource, options = {}) {
        // Ensure headers exist
        options.headers = options.headers || new Headers();
        
        // Remove the Cookie header
        removeCookieHeader(options.headers);

        // Proceed with the modified fetch request
        const response = await originalFetch.call(this, resource, options);
        
        // Log request details if the response is 200 OK
        if (response.status === 200) {
            console.log(`Fetch Request URL: ${resource}`);
            console.log(`Response Status: ${response.status}`);
            const responseBody = await response.clone().text();
            console.log(`Response Body: ${responseBody}`);
        }
        
        return response;
    };

    // Intercepting XMLHttpRequest (XHR)
    const originalOpen = XMLHttpRequest.prototype.open;
    XMLHttpRequest.prototype.open = function(method, url) {
        this.addEventListener('readystatechange', function() {
            if (this.readyState === 4 && this.status === 200) {
                console.log(`XHR Request URL: ${url}`);
                console.log(`Response Status: ${this.status}`);
                console.log(`Response Body: ${this.responseText}`);
            }
        });

        return originalOpen.apply(this, arguments);
    };

    // Intercepting XHR to modify request headers
    const originalSetRequestHeader = XMLHttpRequest.prototype.setRequestHeader;
    XMLHttpRequest.prototype.setRequestHeader = function(header, value) {
        // Prevent setting Cookie header
        if (header.toLowerCase() !== 'cookie') {
            originalSetRequestHeader.apply(this, arguments);
        }
    };

})();
