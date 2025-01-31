unit FormMainLab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, StdActns, ToolWin, ActnMan, ActnCtrls,
  XPStyleActnCtrls, ImgList, ExtCtrls, StdCtrls, ComCtrls, UTrieTree, UTrieTreeNode;

type
  TFormMain = class(TForm)
    MainMenu: TMainMenu;
    mi_file: TMenuItem;
    mi_edit: TMenuItem;
    mi_search: TMenuItem;
    mi_task: TMenuItem;
    mi_new: TMenuItem;
    mi_open: TMenuItem;
    mi_save: TMenuItem;
    mi_saveas: TMenuItem;
    mi_close: TMenuItem;
    mi_exit: TMenuItem;
    mi_add: TMenuItem;
    mi_delete: TMenuItem;
    mi_clear: TMenuItem;
    ActionList: TActionList;
    act_new: TAction;
    act_open: TAction;
    act_save: TAction;
    act_saveAs: TAction;
    act_close: TAction;
    act_exit: TAction;
    act_add: TAction;
    act_delete: TAction;
    act_clear: TAction;
    act_search: TAction;
    act_task: TAction;
    ActionManager: TActionManager;
    PanelTree: TPanel;
    SplitterMain: TSplitter;
    PanelInformation: TPanel;
    TreeView: TTreeView;
    MemoResult: TMemo;
    mi_separator2: TMenuItem;
    mi_separator1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;


    function TrySaveAndContinue: boolean;
    procedure FormCreate(Sender: TObject);
    procedure act_exitExecute(Sender: TObject);
    procedure act_openExecute(Sender: TObject);
    procedure act_saveExecute(Sender: TObject);
    procedure act_saveAsExecute(Sender: TObject);
    procedure act_newExecute(Sender: TObject);
    procedure act_closeExecute(Sender: TObject);
    procedure act_addExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure act_clearExecute(Sender: TObject);
    procedure act_searchExecute(Sender: TObject);
    procedure act_deleteExecute(Sender: TObject);
    procedure act_taskExecute(Sender: TObject);

  protected
    procedure SetIsSaved(value: boolean);
    procedure SetIsFileOpen(value: boolean);
    class function StringToSet(str: string): TSet;

  private
    FIsSaved: boolean;
    FIsFileOpen: boolean;
    FFileName: string;
    FTree: TTrie;

  public
    property IsSaved: boolean read FIsSaved write SetIsSaved;
    property IsFileOpen: boolean read FIsFileOpen write SetIsFileOpen;
  end;


const
  default_fileName = '����������.txt';

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.SetIsSaved(value: boolean);
begin
  FIsSaved := value;
  act_save.Enabled := not value;
end;

procedure TFormMain.SetIsFileOpen(value: boolean);
begin
  FIsFileOpen := value;
  act_save.Enabled := value;
  act_saveAs.Enabled := value;
  act_close.Enabled := value;
  act_add.Enabled := value;
  act_delete.Enabled := value;
  act_clear.Enabled := value;
  act_search.Enabled := value;
  act_task.Enabled := value;
end;

// ���������, �������� �� ����, ����� ���������� ��������
function TFormMain.TrySaveAndContinue: boolean;
var
  responce: integer;
begin
  if IsSaved then
    Result := true
  else
    begin
      Result := false;
      responce := MessageDlg('�� ������ ��������� ���������?',
                              mtConfirmation,
                              mbYesNoCancel,
                              0);
      case responce of
        mrNo:
          Result := true;
        mrYes:
          if SaveDialog.Execute then
            begin
              FFileName := SaveDialog.FileName;
              FTree.SaveToFile(FFileName);
              Result := true;
            end
      end;
    end;
end;

// ������������� �����
procedure TFormMain.FormCreate(Sender: TObject);
begin
  IsFileOpen := false;
  IsSaved := true;
  FFileName := default_fileName;
  FTree := TTrie.Create;
end;

// ����� �� ���������
procedure TFormMain.act_exitExecute(Sender: TObject);
begin
  Close;
end;

// ������� ����
procedure TFormMain.act_openExecute(Sender: TObject);
begin
  if TrySaveAndContinue and OpenDialog.Execute then
    begin
      FFileName := OpenDialog.FileName;
      FTree.LoadFromFile(FFileName);
      FTree.PrintToTV(TreeView);
      MemoResult.Lines.Clear;
      IsFileOpen := true;
      IsSaved := true;
    end;

end;

// ���������
procedure TFormMain.act_saveExecute(Sender: TObject);
begin
  FTree.SaveToFile(FFileName);
  IsSaved := true;
end;

// ��������� ���
procedure TFormMain.act_saveAsExecute(Sender: TObject);
begin
  if SaveDialog.Execute then
    begin
      FFileName := SaveDialog.FileName;
      FTree.SaveToFile(FFileName);
      IsSaved := true;
    end;
end;

// ������� ����� ����
procedure TFormMain.act_newExecute(Sender: TObject);
begin
  if TrySaveAndContinue then
    begin
      FFileName := default_fileName;
      FTree.Clear;
      IsFileOpen := true;
      IsSaved := true;
      MemoResult.Lines.Clear;
    end;
end;

// ������� ����
procedure TFormMain.act_closeExecute(Sender: TObject);
begin
  if TrySaveAndContinue then
    begin
      FFileName := default_fileName;
      FTree.Clear;
      FTree.PrintToTV(TreeView);
      IsFileOpen := false;
      IsSaved := true;
      MemoResult.Lines.Clear;
    end;
end;

// ���������� ����� � ������
procedure TFormMain.act_addExecute(Sender: TObject);
var
  word: string;
begin
  word := InputBox('�������� �����',
                    '������� �����, ������� ������ ��������', '');
  if not FTree.Add(word) then
    ShowMessage('��������� ����� �����������')
  else
    begin
      FTree.PrintToTV(TreeView);
      IsSaved := false;
    end;
end;

// ��� �������� �����
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if TrySaveAndContinue then
    FTree.Clear
  else
    Action := caNone
end;

// �������� ������
procedure TFormMain.act_clearExecute(Sender: TObject);
var
  responce: integer;
begin
  responce := MessageDlg('�������� ������?',
                              mtConfirmation,
                              mbYesNoCancel,
                              0);
  if responce = mrYes then
    begin
      FTree.Clear;
      FTree.PrintToTV(TreeView);
      IsSaved := false;
    end;
end;

// ����� �����
procedure TFormMain.act_searchExecute(Sender: TObject);
var
  word: string;
begin
  word := InputBox('����� �����',
                    '������� �����, ������� ������ �����', '');
  if FTree.Find(word) then
    ShowMessage('��������� ����� �������')
  else
    ShowMessage('��������� ����� �� ������� ��� �����������')

end;

procedure TFormMain.act_deleteExecute(Sender: TObject);
var
  word: string;
begin
  word := InputBox('�������� �����',
                    '������� �����, ������� ������ �������', '');
  if FTree.Delete(word) then
    begin
      FTree.PrintToTV(TreeView);
      IsSaved := false;
      ShowMessage('��������� ����� �������');
    end
  else
    ShowMessage('��������� ����� �� ������� ��� �����������')
end;

class function TFormMain.StringToSet(str: string): TSet;
var
  i: integer;
begin
  Result := [];
  for i:=1 to length(str) do
    Result := Result + [str[i]]
end;

procedure TFormMain.act_taskExecute(Sender: TObject);
var
  wrd, s: string;
  count: integer;
begin
  wrd := InputBox('����� ���� �� ��������� ��������',
                    '������� ������������������ ��������, � ������� ����� ���������� �����/�', '');
  if wrd <> '' then
    begin
      count:= FTree.FindWordsWithStr(wrd);
      Str(count, s);
      MemoResult.Lines.Add('���� ������������ � "'+ wrd +'" : ' + s);
    end
  else
    ShowMessage('�������� ����! ����� ������ ���� �� ���� ������');
end;



end.
