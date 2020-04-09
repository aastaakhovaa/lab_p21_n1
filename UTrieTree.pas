unit UTrieTree;

interface

uses
  UTrieTreeNode, Classes, SysUtils, ComCtrls;

type
  TTrie = class
    private
      FRoot: TNode;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Clear; virtual;
      function Add(word: string): boolean; virtual;
      function Find(word: string): boolean;
      function Delete(word: string): boolean; virtual;
      function IsEmpty: boolean;
      procedure View(str: TStrings);
      procedure SaveToFile(FileName: string); virtual;
      function LoadFromFile(FileName: string): boolean; virtual;
      procedure PrintToTV(TV: TTreeView);
      function FindWordsWithStr(word: string): integer;
  end;

implementation

{ TTrie }

// Добавление слова
function TTrie.Add(word: string): boolean;
begin
  if TNode.CheckWord(word) then
    begin
      if FRoot = nil then
        FRoot := TNode.Create;
      Result := FRoot.Add(word);
    end
  else
    Result := false
end;

// Очистка дерева
procedure TTrie.Clear;
begin
  FreeAndNil(FRoot);
end;

constructor TTrie.Create;
begin
  inherited Create;
  FRoot := nil;
end;

// Удаление слова
function TTrie.Delete(word: string): boolean;
begin
  Result := (FRoot <> nil) and
            TNode.CheckWord(word) and
            FRoot.Delete(word);
  if Result and FRoot.IsEmpty then
    FreeAndNil(FRoot)
end;

destructor TTrie.Destroy;
begin
  FRoot.Destroy;
  inherited;
end;

// Поиск слова
function TTrie.Find(word: string): boolean;
begin
  Result := (FRoot <> nil) and
            TNode.CheckWord(word) and
            FRoot.Find(word)
end;

// Проверка на пустоту
function TTrie.IsEmpty: boolean;
begin
  Result := FRoot = nil
end;

// Чтение дерева из файла
function TTrie.LoadFromFile(FileName: string): boolean;

  // Получение из str следующего слова с перемещением i за это слово
  function NextWord(str: string; var i: integer): string;
  var
    len: integer;
  begin
    len := length(str);
    while (i < len) and not (str[i] in ['a'..'z']) do
      inc(i);
    Result := '';
    while (i <= len) and (str[i] in ['a'..'z']) do
      begin
        Result := Result + str[i];
        inc(i);
      end;
  end;

var
  f: TextFile;
  str, wrd: String;
  i, len: integer;
begin
  AssignFile(f, FileName);
  reset(f);
  Clear;
  Result := true;
  while not eof(f) do
    begin
      readln(f, str);
      len := length(str);
      i := 1;
      while (i <= len) and Result do
        begin
          wrd := NextWord(str, i);
          if (wrd <> '') and TNode.CheckWord(wrd) then
            Add(wrd)
          else
            Result := false
        end;
    end;
  Close(f);
end;

// Вывод дерева на TreeView (TV)
procedure TTrie.PrintToTV(TV: TTreeView);
begin
  TV.Items.Clear;
  if FRoot <> nil then
    FRoot.PrintAllWordsToTV(TV, nil);
  TV.FullExpand;
end;

// Сохранение дерева в текстовый файл
procedure TTrie.SaveToFile(FileName: string);
var
  str: TStrings;
begin
  str := TStringList.Create;
  View(str);
  str.SaveToFile(FileName);
  str.Free;
end;

// Вывод дерева в TStrings
procedure TTrie.View(str: TStrings);
begin
  str.Clear;
  if FRoot <> nil then
    FRoot.View(str, '');
end;

// поиск всех слов, содержащих только символы заданного множества
function TTrie.FindWordsWithStr(word: string): integer;
var
  str: string;
begin
  Result := 0;
  if FRoot <> nil then
    FRoot.FindWordsWithStr(str, Result, word);
end;

end.
