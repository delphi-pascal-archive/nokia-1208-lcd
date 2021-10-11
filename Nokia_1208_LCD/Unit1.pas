unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


const
NNOP=$00;
SWRESET=$01;
BSTROFF=$02;
BSTRON=$03;
RDDIFIF=$04;
RDDST=$09;
Sleep_IN=$10;
Sleep_OUT=$11;
PTLON=$12;
NORON=$13;
INVOFF=$20;
INVON=$21;
DALO=$22;
DAL=$23;
SETCON=$25;
DISPOFF=$28;
DISPON=$29;
CASET=$2A;
PASET=$2B;
RAMWR=$2C;
RGBSET=$2D;
PTLAR=$30;
VSCRDEF=$33;
TEOFF=$34;
TEON=$35;
MADCTL=$36;
SEP=$37;
IDMOFF=$38;
IDMON=$39;
COLMOD=$3A;
SETVOP=$B0;
BRS=$B4;
TRS=$B6;
FINV=$B9;
DOR=$BA;
TCDFE=$BD;
TCVOPE=$BF;
EC=$C0;
SETMUL=$C2;
TCVOPAB=$C3;
TCVOPCD=$C4;
TCDF=$C5;
DF8colour=$C6;
SETBS=$C7;
NLI=$C9;




var
  Form1: TForm1;
  Bufer:array[0..6929]of byte;
implementation
{$R *.dfm}
Function  Inp32(PortAddress:dword):byte;stdcall;external 'inpout32.dll';
Procedure Out32(PortAddress:dword;ddata:byte);stdcall;external 'inpout32.dll';

procedure PortOFF;forward;
procedure VccON;forward;
procedure SDA_0;forward;
procedure SDA_1;forward;
procedure CLK_0;forward;
procedure CLK_1;forward;
procedure CS_0;forward;
procedure CS_1;forward;
procedure RST_0;forward;
procedure RST_1;forward;
procedure WriteComand(CC:byte);forward;
procedure WriteDATA(DD:byte);forward;
//===============================================================
procedure PortOFF;
var NN:byte;
begin
Out32($378,$00);
NN:=Inp32($37A);
NN:=NN or 1;
Out32($37A,NN);
end;
//===============================================================
procedure VccON;
var NN:byte;
begin
NN:=Inp32($37A);
NN:=NN and $FE;
Out32($37A,NN);
end;
//===============================================================
procedure SDA_0;
var NN:byte;
begin
NN:=Inp32($378);
NN:=NN and $FE;
Out32($378,NN);
end;
//===============================================================
procedure SDA_1;
var NN:byte;
begin
NN:=Inp32($378);
NN:=NN or $01;
Out32($378,NN);
end;
//===============================================================
procedure CLK_0;
var NN:byte;
begin
NN:=Inp32($378);
NN:=NN and $FD;
Out32($378,NN);
end;
//===============================================================
procedure CLK_1;
var NN:byte;
begin
NN:=Inp32($378);
NN:=NN or $02;
Out32($378,NN);
end;
//===============================================================
procedure CS_0;
var NN:byte;
begin
NN:=Inp32($378);
NN:=NN and $FB;
Out32($378,NN);
end;
//===============================================================
procedure CS_1;
var NN:byte;
begin
NN:=Inp32($378);
NN:=NN or $04;
Out32($378,NN);
end;
//===============================================================
procedure RST_0;
var NN:byte;
begin
NN:=Inp32($378);
NN:=NN and $F7;
Out32($378,NN);
end;
//===============================================================
procedure RST_1;
var NN:byte;
begin
NN:=Inp32($378);
NN:=NN or $08;
Out32($378,NN);
end;
//===============================================================
procedure TForm1.FormShow(Sender: TObject);
begin
PortOFF;
end;
//===============================================================
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
PortOFF;
end;
//===============================================================
procedure WriteComand(CC:byte);
begin
 CS_0;
 SDA_0;
 CLK_0;
 CLK_1;
 IF (CC and $80)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (CC and $40)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (CC and $20)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (CC and $10)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (CC and $08)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (CC and $04)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (CC and $02)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (CC and $01)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 CS_1;
end;
//===============================================================
procedure WriteDATA(DD:byte);
begin
 CS_0;
 CLK_0;
 SDA_1;
 CLK_0;
 CLK_1;
 IF (DD and $80)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (DD and $40)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (DD and $20)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (DD and $10)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (DD and $08)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (DD and $04)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (DD and $02)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 IF (DD and $01)=0 Then SDA_0 ELSE SDA_1;
 CLK_0;
 CLK_1;
 CS_1;
end;
//===============================================================



//===============================================================
procedure TForm1.Button1Click(Sender: TObject);
var XX,YY,CC,NN:dword; BB,BL,GR,RD:byte;
begin
  CS_0;
  CS_0;
  CS_0;
  //WriteComand(DISPOFF);

  WriteComand(CASET);
  WriteDATA(0);
  WriteDATA(98);
  WriteComand(PASET);
  WriteDATA(0);
  WriteDATA(69);
  WriteComand(RAMWR);

  For YY:=0 to 69 do
  For XX:=0 to 98 do
    begin
    CC:=Form1.Image1.Picture.Bitmap.Canvas.Pixels[XX,YY];
    RD:=CC and $000000FF;
    CC:=CC SHR 8;
    GR:=CC and $000000FF;
    CC:=CC SHR 8;
    BL:=CC and $000000FF;
    RD:=RD and $E0;
    GR:=GR and $E0;
    GR:=GR SHR 3;
    BL:=BL and $C0;
    BL:=BL SHR 6;
    BB:=RD or GR or BL;
    WriteDATA(BB);
    end;
  //WriteComand(DISPON);
  CS_1;
  ShowMessage('OK');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
VccON;
RST_1;
CS_1;
CLK_0;
SDA_0;
Sleep(20);
RST_0;
Sleep(20);
RST_1;
Sleep(20);
CLK_1;
SDA_1;
//Sleep(20);

WriteComand(Sleep_OUT);
WriteComand(BSTRON);
//Sleep(20);
WriteComand(MADCTL);

WriteComand(COLMOD);
WriteDATA($02);  //8 bit pixel

WriteComand(SETCON);
WriteDATA(64);    //$30
//Sleep(20);
WriteComand(NNOP);
WriteComand(DISPON);
//WriteComand(DAL);

ShowMessage('Port ON');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
PortOFF;
ShowMessage('Port OFF');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
VccON;
RST_1;
CS_1;
CLK_0;
SDA_0;
Sleep(200);
RST_0;
Sleep(200);
RST_1;
Sleep(200);
CLK_1;
SDA_1;
Sleep(200);
WriteComand($CA); //DISCTL
WriteDATA($0C);
WriteDATA($20);
WriteDATA($00);
WriteDATA($01);
WriteComand($BB); //COMSCN
WriteDATA($01);
WriteComand($D1); //OSCON
WriteComand($94); //Sleep Out
WriteComand($20); //PWRCTR
WriteDATA($0F);
WriteComand($BC); //DATCTL
WriteDATA($03);
WriteDATA($00);
WriteDATA($02);
WriteComand($81); //VOLCTR
WriteDATA($24);
WriteComand($25); //NOP
WriteComand($AF); //DISPON

ShowMessage('Port ON');
end;

procedure TForm1.Button4Click(Sender: TObject);
var XX,YY,CC,NN:dword; BB,BL,GR,RD:byte;
begin
  CS_0;
  CS_0;
  CS_0;
  //WriteComand(DISPOFF);

  WriteComand($15);  //CASET
  WriteDATA(0);
  WriteDATA(131);
  WriteComand($75);    //PASET
  WriteDATA(0);
  WriteDATA(131);
  WriteComand($5C);   //RAMWR

  For YY:=0 to 131 do
  For XX:=0 to 131 do
    begin
    CC:=Form1.Image1.Picture.Bitmap.Canvas.Pixels[XX,YY];
    RD:=CC and $000000FF;
    CC:=CC SHR 8;
    GR:=CC and $000000FF;
    CC:=CC SHR 8;
    BL:=CC and $000000FF;
    RD:=RD and $E0;
    GR:=GR and $E0;
    GR:=GR SHR 3;
    BL:=BL and $C0;
    BL:=BL SHR 6;
    BB:=RD or GR or BL;
    WriteDATA(BB);
    end;
  //WriteComand(DISPON);
  CS_1;
  ShowMessage('OK');
end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
IF Not(OpenDialog1.Execute) Then Exit;
Form1.Image1.Picture.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Button3Click(Sender: TObject);
var XX,YY,CC,NN:dword; BB,BL,GR,RD:byte;
FHandle:dword;
begin
IF Not(SaveDialog1.Execute) Then Exit;

  NN:=0;
  For YY:=0 to 69 do
  For XX:=0 to 98 do
    begin
    CC:=Form1.Image1.Picture.Bitmap.Canvas.Pixels[XX,YY];
    RD:=CC and $000000FF;
    CC:=CC SHR 8;
    GR:=CC and $000000FF;
    CC:=CC SHR 8;
    BL:=CC and $000000FF;
    RD:=RD and $E0;
    GR:=GR and $E0;
    GR:=GR SHR 3;
    BL:=BL and $C0;
    BL:=BL SHR 6;
    BB:=RD or GR or BL;
    Bufer[NN]:=BB;
    inc(NN);
    end;

 IF FileExists(SaveDialog1.FileName) Then
   FHandle:=FileOpen(SaveDialog1.FileName, fmOpenWrite)
   Else
   FHandle:=FileCreate(SaveDialog1.FileName);

 FileWrite(FHandle, Bufer, Sizeof (Bufer));
 FileClose(FHandle);


  ShowMessage('File saved');
end;

end.
