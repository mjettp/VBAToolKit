VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "vtkExcelUtilitiesTester"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Implements ITest
Implements ITestCase

Private mManager As TestCaseManager
Private mAssert As IAssert

Private Sub Class_Initialize()
    Set mManager = New TestCaseManager
End Sub

Private Property Get ITestCase_Manager() As TestCaseManager
    Set ITestCase_Manager = mManager
End Property

Private Property Get ITest_Manager() As ITestManager
    Set ITest_Manager = mManager
End Property

Private Sub ITestCase_SetUp(Assert As IAssert)
    Set mAssert = Assert
End Sub

Private Sub ITestCase_TearDown()
    VBAToolKit.resetTestFolder
End Sub

Public Sub Test_vtkDefaultIsAddIn()
    mAssert.Should vtkDefaultIsAddIn("TestFile.xla"), "xla extension is Add-In"
    mAssert.Should vtkDefaultIsAddIn("TestFile.xlam"), "xlam extension is Add-In"
    mAssert.Should Not vtkDefaultIsAddIn("TestFile.xlsx"), "xlsx extension is not Add-In"
    mAssert.Should Not vtkDefaultIsAddIn("TestFile.xltx"), "xltx extension is not Add-In"
    mAssert.Should Not vtkDefaultIsAddIn("TestFile.xlsm"), "xlsm extension is not Add-In"
    mAssert.Should Not vtkDefaultIsAddIn("TestFile.xltm"), "xltm extension is not Add-In"
    mAssert.Should Not vtkDefaultIsAddIn("TestFile.xls"), "xls extension is not Add-In"
End Sub

Public Sub Test_vtkProtectProject()
    Dim Wb As Workbook, fullName As String, component As VBComponent
    ' Create a new workbook for test, and populate it with a code module
    Set Wb = vtkCreateExcelWorkbookForTestWithProjectName(projectName:="TestProject")
    Set component = Wb.VBProject.VBComponents.Add(vbext_ct_StdModule)
    component.CodeModule.AddFromString "Sub Test" & vbCrLf & "End Sub"
    ' Save, Close and Reopen the verify there is no protection
    fullName = Wb.fullName
    Wb.Close saveChanges:=True
    Set Wb = Workbooks.Open(fileName:=fullName)
    mAssert.Should Not Wb.VBProject.Protection, "Project must not be protected"
    ' Protect, then Save, close and reopen to verify there is a protection
    vtkProtectProject project:=Wb.VBProject, password:="aPassword"
    fullName = Wb.fullName
    Wb.Close saveChanges:=True
    Set Wb = Workbooks.Open(fileName:=fullName)
    mAssert.Should Wb.VBProject.Protection, "Project must be protected"
    ' Kill test workbook
    vtkCloseAndKillWorkbook Wb:=Wb
End Sub

Public Sub Test_vtkDefaultExcelExtension()
    mAssert.Equals ".xlsm", vtkDefaultExcelExtension, "Default Excel 2007 extension"
End Sub

Private Function ITest_Suite() As TestSuite
    Set ITest_Suite = New TestSuite
    ITest_Suite.AddTest ITest_Manager.ClassName, "Test_vtkDefaultIsAddIn"
    ITest_Suite.AddTest ITest_Manager.ClassName, "Test_vtkProtectProject"
    ITest_Suite.AddTest ITest_Manager.ClassName, "Test_vtkDefaultExcelExtension"
End Function

Private Sub ITestCase_RunTest()
    Select Case mManager.methodName
        Case "Test_vtkDefaultIsAddIn": Test_vtkDefaultIsAddIn
        Case "Test_vtkProtectProject": Test_vtkProtectProject
        Case "Test_vtkDefaultExcelExtension": Test_vtkDefaultExcelExtension
        Case Else: mAssert.Should False, "Invalid test name: " & mManager.methodName
    End Select
End Sub
