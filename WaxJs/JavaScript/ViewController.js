const ButtonTag_ac = -8;
const ButtonTag_addminus = -7;
const ButtonTag_amount = -6;
const ButtonTag_divide = -5;
const ButtonTag_multiply = -4;
const ButtonTag_minuns = -3;
const ButtonTag_add = -2;
const ButtonTag_dot = -1;

const DigitalType_Error = -4;
const DigitalType_Add = -3;
const DigitalType_Minus = -2;
const DigitalType_None = -1;
const DigitalType_0 = 0;
const DigitalType_1 = 1;
const DigitalType_2 = 2;
const DigitalType_3 = 3;
const DigitalType_4 = 4;
const DigitalType_5 = 5;
const DigitalType_6 = 6;
const DigitalType_7 = 7;
const DigitalType_8 = 8;
const DigitalType_9 = 9;

const NO = false;
const YES = true;

var number = "0";  //被操作数
var operatorTag = 0;    //操作符
var operateNumber = "0";   //操作数

var inputToRest = false; //输入则重置状态

showNumber(number);

var onButtonClick = function(tag){
    log("onButtonClick "+tag);
    if (tag >=0 && tag <= 9) {
        
        if (inputToRest) {
            operatorTag = 0;
            number = "0";
        }
        
        if(operatorTag == 0) {
            if(number == "0") {
                number = tag.toString();
            }else{
                number = number + tag.toString();
            }
            showNumber(number);
        }else{
            if(operateNumber == "0") {
                operateNumber = tag.toString();
            }else{
                operateNumber = operateNumber+tag.toString();
            }
            showNumber(operateNumber);
        }
        
        inputToRest = false;
    }else if (tag == ButtonTag_ac) {
        //ac
        number = 0;
        operatorTag = 0;
        operatNumber= 0;
        showNumber(number);
        inputToRest = false;
    }else if (tag == ButtonTag_add || tag == ButtonTag_minuns || tag == ButtonTag_multiply || tag == ButtonTag_divide) {
        
        if (!inputToRest && operateNumber!=0) {
            amount();
        }
        
        //+ - * /
        operatorTag = tag;
        operateNumber = 0;
        inputToRest = false;
    }else if (tag == ButtonTag_amount) {
        //=
        amount();
        inputToRest = true;
        
    }else if (tag == ButtonTag_addminus) {
        //+/-
        var numberNum = parseFloat(number);
        number = -numberNum + "";
        showNumber(number);
    }else if (tag == ButtonTag_dot) {
        //.
        if(operatorTag == 0) {
            if(!number.includes(".")) {
                number = number + ".";
                showNumber(number);
            }
        }else{
            if(!operateNumber.includes(".")) {
                operateNumber = operateNumber + ".";
                showNumber(operateNumber);
            }
        }
    }
    
    JSAudioUtil.playSystemSound(1105);  //播放音效
};

function amount(){
    var numberNum = parseFloat(number);
    var operateNumberNum = parseFloat(operateNumber);
    if (operatorTag == ButtonTag_add) {
        number = numberNum + operateNumberNum + "";
        showNumber(number);
    }else if (operatorTag == ButtonTag_minuns) {
        number = numberNum - operateNumberNum + "";
        showNumber(number);
    }else if (operatorTag == ButtonTag_multiply) {
        number = numberNum * operateNumberNum + "";
        showNumber(number);
    }else if (operatorTag == ButtonTag_divide) {
        if(operateNumber != 0) {
            number = numberNum / operateNumberNum + "";
            showNumber(number);
        }else{
            showResult("ERROR");
        }
    }
}

function showNumber(number) {
    var result = number.toString();
    var digitalsNum = 11;
    if(result.includes(".")) {
        digitalsNum = 11;
    }
    if (result.length > digitalsNum) {
        result = result.substr(0, digitalsNum);
    }
    showResult(result);
}

function showResult(result) {
    var _digitalViews = self.screenView.digitalViews;
    
    for (var i = 0; i < _digitalViews.length; i++) {
        var digitalView = _digitalViews[i];
        digitalView.dotImageView.hidden = YES;
        showDigital(digitalView, DigitalType_None);
    }
    
    if (result == "ERROR") {
        self.screenView.errorImageView.hidden = NO;
        return;
    }else{
        self.screenView.errorImageView.hidden = YES;
    }
    
    var numberCount = 0;
    for (var i = 0; i < _digitalViews.length; i++) {
        if (i < result.length) {
            var c = result.charAt(result.length-i-1);
            if (c == '-') {
                var digitalView = _digitalViews[numberCount];
                showDigital(digitalView, DigitalType_Minus);
                numberCount++;
            }else if (c == '.') {
                var digitalView = _digitalViews[numberCount];
                digitalView.dotImageView.hidden = NO;
            }else if (c >= '0' && c <= '9') {
                var digitalView = _digitalViews[numberCount];
                showDigital(digitalView, c - '0');
                numberCount++;
            }
        }else{
            break;
        }
    }
    
}

function showDigital(digitalView, digital)
{
    var _digitalImageView = digitalView.digitalImageView;
    if (digital>=0 && digital <= 9) {
        _digitalImageView.setImageName("pic"+digital.toString()+".png");
    }else if (digital==DigitalType_Minus) {
        _digitalImageView.setImageName("pic_minus.png");
    }else if (digital==DigitalType_Add) {
        _digitalImageView.setImageName("pic_add.png");
    }else if (digital==DigitalType_Error) {
        _digitalImageView.setImageName("pic_e.png");
    }else{
        _digitalImageView.setImageName(null);
    }
    
}
