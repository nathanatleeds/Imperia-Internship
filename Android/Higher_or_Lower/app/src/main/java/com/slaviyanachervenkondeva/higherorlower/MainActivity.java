package com.slaviyanachervenkondeva.higherorlower;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import java.util.Random;

public class MainActivity extends AppCompatActivity {

    int randomNum;
    Random rand = new Random();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);



        randomNum = rand.nextInt(20) + 1;
    }

    public void guess(View view) {
        EditText guessEditText = (EditText) findViewById(R.id.guessEditText);


        int inputNum = Integer.parseInt(guessEditText.getText().toString());

        if(randomNum > inputNum) {
            makeToast("Higher");
        }
        else if(randomNum < inputNum) {
            makeToast("Lower");
        }
        else {
            makeToast("That's right! Try again!");
            randomNum = rand.nextInt(20) + 1;
        }
    }

    public void makeToast(String string) {
        Toast.makeText(MainActivity.this,
                string, Toast.LENGTH_SHORT).show();
    }
}
