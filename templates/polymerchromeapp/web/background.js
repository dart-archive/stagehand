/**
 * Created by kevin on 3/24/2015.
 */

chrome.app.runtime.onLaunched.addListener(function(launchData) {
    chrome.app.window.create('index.html', {
        'id': '_mainWindow', 'bounds': {'width': 800, 'height': 600 }
    });
});
