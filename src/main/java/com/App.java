package com;

import java.util.ResourceBundle;

public abstract class App {

    private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle.getBundle("app");

    public static final String CLIENT_ID = RESOURCE_BUNDLE.getString("client.id");

    public static final String CLIENT_SECRET = RESOURCE_BUNDLE.getString("client.secret");
}