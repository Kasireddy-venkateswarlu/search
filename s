// Function to detect known libraries and their versions
function detectJSLibraries() {
    let libraries = [];

    // Example known libraries with version checks
    if (typeof jQuery !== 'undefined') {
        libraries.push({ name: 'jQuery', version: jQuery.fn.jquery });
    }

    if (typeof angular !== 'undefined') {
        libraries.push({ name: 'AngularJS', version: angular.version.full });
    }

    if (typeof Vue !== 'undefined') {
        libraries.push({ name: 'Vue.js', version: Vue.version });
    }

    if (typeof React !== 'undefined') {
        libraries.push({ name: 'React', version: React.version });
    }

    if (typeof _ !== 'undefined' && typeof _.VERSION !== 'undefined') {
        libraries.push({ name: 'Lodash', version: _.VERSION });
    }

    if (typeof Backbone !== 'undefined') {
        libraries.push({ name: 'Backbone.js', version: Backbone.VERSION });
    }

    // Output detected libraries
    if (libraries.length > 0) {
        console.log("Detected Libraries:");
        libraries.forEach(lib => console.log(`${lib.name} - Version: ${lib.version}`));
    } else {
        console.log("No known libraries detected.");
    }

    return libraries;
}

// Run the detection
let detectedLibraries = detectJSLibraries();

// Function to query a mock vulnerability database (replace with real API or DB)
function checkVulnerabilities(libraries) {
    // Example data structure of known vulnerabilities
    const vulnerabilityDB = {
        'jQuery': {
            '3.5.0': 'CVE-2020-11023',
            '3.4.1': 'CVE-2019-11358'
        },
        'AngularJS': {
            '1.6.5': 'CVE-2018-14773'
        },
        'Vue.js': {
            '2.5.0': 'CVE-2019-15117'
        },
        'React': {
            '15.6.0': 'CVE-2017-18230'
        },
        'Lodash': {
            '4.17.20': 'CVE-2021-23337'
        },
        'Backbone.js': {
            '1.3.3': 'CVE-2016-10537'
        }
    };

    libraries.forEach(lib => {
        const vulns = vulnerabilityDB[lib.name];
        if (vulns && vulns[lib.version]) {
            console.warn(`⚠️ ${lib.name} v${lib.version} has known vulnerabilities: ${vulns[lib.version]}`);
        } else {
            console.log(`✅ ${lib.name} v${lib.version} has no known vulnerabilities in the database.`);
        }
    });
}

// Check vulnerabilities based on detected libraries
checkVulnerabilities(detectedLibraries);
