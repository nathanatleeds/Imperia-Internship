package com.slaviyanachervenkondeva.timetable;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.SeekBar;

import java.util.ArrayList;


public class MainActivity extends AppCompatActivity {

    SeekBar timetableSeekBar;
    ListView timetableListView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        timetableSeekBar = findViewById(R.id.timetableSeekBar);
        timetableListView = findViewById(R.id.timetableListView);

        timetableSeekBar.setMax(20);
        timetableSeekBar.setProgress(10);

        timetableSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                int min = 1;
                int timetable;

                if(progress < min) {
                    timetable = 1;
                    timetableSeekBar.setProgress(min);
                } else {
                    timetable = progress;
                }

                Log.i("Seekbar value", Integer.toString(timetable));
                generateTimetable(timetable);
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        generateTimetable(10);
    }

    public void generateTimetable(int timetable) {
        ArrayList<String> timetableContent = new ArrayList<>();

        for (int i = 1; i <= 10; i++) {
            timetableContent.add(Integer.toString(i * timetable));
        }

        ArrayAdapter<String> arrayAdapter =
                new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, timetableContent);

        timetableListView.setAdapter(arrayAdapter);
    }
}
