package com.slaviyanachervenkondeva.textfielddemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    public void buttonClicked(View view) {

        EditText usernameTextField = (EditText) findViewById(R.id.usernameTextField);
        EditText passwordTextField = (EditText) findViewById(R.id.passwordTextField);

        Log.i("Username", usernameTextField.getText().toString());
        Log.i("Password", passwordTextField.getText().toString());

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
