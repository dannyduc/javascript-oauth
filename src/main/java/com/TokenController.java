package com;

import com.sun.jersey.api.client.Client;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

@Controller
public class TokenController {


    @RequestMapping("/token")
    @ResponseBody
    public String getToken(@RequestParam("code") String code) throws UnsupportedEncodingException {

        String clientId = App.CLIENT_ID;
        String clientSecret = App.CLIENT_SECRET;


        String encodedCode = URLEncoder.encode(code, "UTF-8");

        String url = "https://github.com/login/oauth/access_token";

        Client client = Client.create();
        String rtn = client.resource(url)
                .queryParam("client_id", clientId)
                .queryParam("client_secret", clientSecret)
                .queryParam("code", encodedCode)
                .type("application/x-www-form-urlencoded")
                .post(String.class);

        System.out.println(rtn);

        String[] pairs = rtn.split("&");
        Map<String, String> nameValues = new HashMap<String, String>();
        for (String pair : pairs) {
            String[] parts = pair.split("=");
            nameValues.put(parts[0], parts[1]);
        }

        return nameValues.get("access_token");
    }
}
