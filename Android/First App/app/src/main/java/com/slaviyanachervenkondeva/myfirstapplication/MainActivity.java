package com.slaviyanachervenkondeva.myfirstapplication;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void clickFunction(View view) {

        EditText myTextField = (EditText) findViewById(R.id.myTextField);

        String hiName  =  "Hi, " + myTextField.getText().toString() + "!";

        Toast.makeText(MainActivity.this, hiName, Toast.LENGTH_LONG).show();

        Log.i("Info", hiName);

    }

    public void changeImg(View view) {
        ImageView img = (ImageView) findViewById(R.id.img);

        //img.setImageResource(R.drawable.android);

        if (img.getDrawable().getConstantState() == getResources().getDrawable( R.drawable.jetpack).getConstantState())
        {
            img.setImageResource(R.drawable.android);
        }
        else
        {
            img.setImageResource(R.drawable.jetpack);
        }

    }
}
