package com.slaviyanachervenkondeva.currencyconverter;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void convert(View view) {
        EditText inputCurrencyEditText = (EditText) findViewById(R.id.inputCurrencyEditText);

        Double gbpAmountDouble = Double.parseDouble(inputCurrencyEditText.getText().toString());
        Double bgnAmountDouble = gbpAmountDouble * 2.20;

        //Double rounded = Math.round(bgnAmountDouble * 100) / 100.0;

        Toast.makeText(MainActivity.this, String.format("%.2f", bgnAmountDouble) +
                " BGN", Toast.LENGTH_LONG).show();

    }
}
