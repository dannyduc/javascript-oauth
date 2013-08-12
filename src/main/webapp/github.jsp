<a href="https://github.com/vjeux/GithubLogin/">
    <img style="position: absolute; top: 0; right: 0; border: 0;" src="https://a248.e.akamai.net/assets.github.com/img/e6bef7a091f5f3138b8cd40bc3e114258dd68ddf/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f7265645f6161303030302e706e67" alt="Fork me on GitHub"></a>
<script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

<style>
    label, textarea, a { display: block; }
    hr { margin: 20px 0; }
    input { width: 300px; }
</style>

<h2>Login</h2>
<button id="login">Login</button>
<label>code <input type="text" id="code"></input></label>
<label>access_token <input type="text" id="access_token"></input></label>
<label>username <input type="text" id="username"></input></label>

<script>
    // Step 2
    $('#login').click(function () {
        window.open('https://github.com' +
                '/login/oauth/authorize' +
//		'?client_id=58a3dcf21a0bae21db44' +
                '?client_id=2c539714b55263801c13' +
                '&scope=gist');
    });

    // Step 4
    window.addEventListener('message', function (event) {
        var code = event.data;
        $('#code').val(code);

        // Step 5
        $.get('/api/token?code=' + code, function (access_token) {
            // Step 7
            $('#access_token').val(access_token);

            $.getJSON('https://api.github.com/user?access_token=' + access_token, function (user) {
                $('#username').val(user.login);
            });
        });
    });
</script>

<hr />

<h2>Interact</h2>
<textarea id="gist_content">Let's make a gist!</textarea>
<button id="gist_new">New private gist</button>
<label>link <input type="text" id="gist_link"></input></label>

<script>
    $('#gist_new').click(function () {
        var url = 'https://api.github.com/gists' +
                '?access_token=' + $('#access_token').val();

        var data = JSON.stringify({
            "public": false,
            "files": {
                "sample.txt": {
                    "content": $('#gist_content').val()
                }
            }
        });

        $.post(url, data, function (gist) {
            $('#gist_link').val(gist.html_url);
        });
    });
</script>
