unit UTrieTreeNode;

interface

uses
  Classes, SysUtils, ComCtrls;

const
  LowCh = 'a';
  HighCh = 'z';

type
  TIndex = LowCh..HighCh;
  TSet = set of char;
  TNode = class
    private
      FPoint: boolean;
      FNext: array[TIndex] of TNode;
    protected
      function GetNext(value: TIndex): TNode;
      procedure SetNext(value: TIndex; aNode: TNode);
    public
      constructor Create;
      destructor Destroy; override;
      function Add(word: string): boolean;
      function Delete(var wrd: string): boolean;
      function Find(wrd: string): boolean;
      function IsEmpty: boolean;
      procedure View(str: TStrings; wrd: string);
      procedure PrintAllWordsToTV(TV: TTreeView; PN: TTreeNode);
      class function CheckWord(wrd: string): boolean;
      // ����� ���� �� ��������� ��������, � ������� ����� ���������� �����
      procedure FindWordsWithStr(str: string; var count:integer; word: string);
      property Point: boolean read FPoint write FPoint;
      property Next[value: TIndex]: TNode read GetNext write SetNext;
  end;

implementation

{ TNode }

// ���������� �����
function TNode.Add(word: string): boolean;
var
  f: char;
begin
  if word = '' then
    begin
      result := not FPoint;
      FPoint := true;
    end
  else
    begin
      f := word[1];
      System.Delete(word, 1, 1);
      if FNext[f] = nil then
        FNext[f] := TNode.Create;
      Result := FNext[f].Add(word)
    end;
end;

class function TNode.CheckWord(wrd: string): boolean;
var
  i: integer;
begin
  i := 1;
  while (i < length(wrd)) and (wrd[i] in [LowCh..HighCh]) do
    inc(i);
  Result := (i = length(wrd)) and (wrd[i] in [LowCh..HighCh])
end;

constructor TNode.Create;
var
  i: TIndex;
begin
  inherited Create;
  FPoint := false;
  for i := LowCh to HighCh do
    FNext[i] := nil
end;

// �������� �����
function TNode.Delete(var wrd: string): boolean;
var
  f: TIndex;
begin
  if wrd = '' then
    begin
      result := FPoint;
      FPoint := false;
    end
  else
    begin
      f := wrd[1];
      System.Delete(wrd, 1, 1);
      Result := (FNext[f] <> nil) and FNext[f].Delete(wrd);
      if Result and FNext[f].IsEmpty then
        FreeAndNil(FNext[f])
    end;
end;

destructor TNode.Destroy;
var
  i: TIndex;
begin
  for i := LowCh to HighCh do
    FreeAndNil(FNext[i]);
  inherited
end;

function TNode.Find(wrd: string): boolean;
begin
  if wrd = '' then
    Result := FPoint
  else
    Result := (FNext[wrd[1]] <> nil) and
              FNext[wrd[1]].Find(copy(wrd, 2, length(wrd)-1))
end;

function TNode.GetNext(value: TIndex): TNode;
begin
  Result := FNext[value]
end;

function TNode.IsEmpty: boolean;
var
  i: TIndex;
begin
  i := LowCh;
  Result := (not FPoint) and (FNext[i] = nil);
  if Result then
    repeat
      inc(i);
      Result := FNext[i] = nil
    until not Result or (i = HighCh)
end;

procedure TNode.PrintAllWordsToTV(TV: TTreeView; PN: TTreeNode); // PN - parent node
var
  ch: TIndex;
begin
  if FPoint then
    TV.Items.AddChild(PN, '.');
  for ch := LowCH to HighCh do
    if FNext[ch] <> nil then
      FNext[ch].PrintAllWordsToTV(TV, TV.Items.AddChild(PN, ch));
end;

procedure TNode.SetNext(value: TIndex; aNode: TNode);
begin
  if FNext[value] <> aNode then
    begin
      FNext[value].Free;
      FNext[value] := aNode
    end
end;

procedure TNode.View(str: TStrings; wrd: string);
var
  i: TIndex;
begin
  if FPoint then str.Add(wrd);
  for i := LowCh to HighCh do
    if FNext[i] <> nil then
      FNext[i].View(str, wrd + i);
end;

// ����� ���� �� ��������� ��������, � ������� ����� ���������� �����
procedure TNode.FindWordsWithStr(str: string; var count: integer; word: string);
var
  i: TIndex;
begin
  if FPoint then
    begin
      if (length(word)) <= (length(str)) then
        if copy(str, 1, length(word)) = word then
          inc(count);
    end;

  for i := LowCh to HighCh do
    if FNext[i] <> nil then
      FNext[i].FindWordsWithStr(str+i, count, word);
end;


end.
