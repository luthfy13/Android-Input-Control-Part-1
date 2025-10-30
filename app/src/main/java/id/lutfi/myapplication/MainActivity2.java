package id.lutfi.myapplication;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.RadioGroup;
import android.widget.TextView;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity2 extends AppCompatActivity {

    private CheckBox chk1, chk2, chk3;
    private TextView txtHasil;
    private RadioGroup rgProdi;

    @SuppressLint("MissingInflatedId")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main2);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        chk1 = findViewById(R.id.chk_1);
        chk2 = findViewById(R.id.chk_2);
        chk3 = findViewById(R.id.chk_3);
        txtHasil = findViewById(R.id.txt_hasil);
        rgProdi = findViewById(R.id.rg_prodi);

    }

    public void onClick(View view){
        String hasil="Hobi:\n";

        if (chk1.isChecked())
            hasil += "- Musik\n";
        if (chk2.isChecked())
            hasil += "- Basket\n";
        if (chk3.isChecked())
            hasil += "- Catur\n";


        hasil += "\nProgram Studi\n";
        int rgId = rgProdi.getCheckedRadioButtonId();
        if (rgId == R.id.rb_ti)
            hasil += "Teknik Informatika\n";
        else if (rgId == R.id.rb_si)
            hasil += "Sistem Informasi\n";

        txtHasil.setText(hasil);


    }

    public void selectAll(View view){
        chk1.setChecked(true);
        chk2.setChecked(true);
        chk3.setChecked(true);
    }

    public void clear(View view){
        chk1.setChecked(false);
        chk2.setChecked(false);
        chk3.setChecked(false);
    }
}