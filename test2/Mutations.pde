class Mutations {
    String[][] mutList;
    String[] alphabetData = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z", "-"};
    Mutations() {
        //ミュータントの初期設定
        mutList = new String[tableLength][];
        mutData = new String[tableLength][];
    }

    void loadData() {
        String data;

        for(int i = 1; i < tableLength; i++) {
            data = strains.getString(i, 12);

            if(data == "") {
                data = "0";
                mutData[i-1] = new String[1];
                mutData[i-1][0] = data;
            }
            else {
                //カンマスプリットの一時保存配列
                String[] spliter = data.split(",");
                mutData[i-1] = new String[spliter.length];

                for(int j = 0; j < spliter.length; j++) {
                    // mutToNum(spliter[j]);
                    mutData[i-1][j] = mutToNum(spliter[j]);
                }
            }            
        }
    }

    // 変化量文字列(A123Tなど)を変化量定数に変換
    String mutToNum(String num) {
        //変化量変数
        int sub = 0;

        //変化量アルファベットの番号化
        int headCharNum = 0;
        int bottomCharNum = 0;
        String[] mutAmount = num.split("");

        for(int i = 0; i < alphabetData.length; i++) {
            if(mutAmount[0].equals(alphabetData[i])) headCharNum = i;
            if(mutAmount[mutAmount.length-1].equals(alphabetData[i])) headCharNum = i;
        }

        sub = Math.abs(bottomCharNum - headCharNum);

         // 変化した番地
        String arrayNum = mutAmount[1];

        for(int i = 2; i < mutAmount.length-1; i++) {
            arrayNum = arrayNum.concat(mutAmount[i]);
            
        }      

        return arrayNum + "," + sub;

    }
}
