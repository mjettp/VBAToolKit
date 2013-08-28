Attribute VB_Name = "vtkTestUtilities"
Option Explicit
'---------------------------------------------------------------------------------------
' Module    : vtkTestUtilities
' Author    : Jean-Pierre Imbert
' Date      : 28/08/2013
' Purpose   : Some utilities to facilitate test writing
'             - vtkTestPath, gives the path of the current project
'
' Copyright 2013 Skwal-Soft (http://skwalsoft.com)
'
'   Licensed under the Apache License, Version 2.0 (the "License");
'   you may not use this file except in compliance with the License.
'   You may obtain a copy of the License at
'
'       http://www.apache.org/licenses/LICENSE-2.0
'
'   Unless required by applicable law or agreed to in writing, software
'   distributed under the License is distributed on an "AS IS" BASIS,
'   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
'   See the License for the specific language governing permissions and
'   limitations under the License.
'---------------------------------------------------------------------------------------


'---------------------------------------------------------------------------------------
' Procedure : vtkTestPath
' Author    : Jean-Pierre Imbert
' Date      : 07/05/2013
' Purpose   : -Return the path of the Test Folder of the current project  '..\VBAToolKit\Tests
'---------------------------------------------------------------------------------------
'
Public Function vtkTestPath() As String
    vtkTestPath = vtkPathToTestFolder
End Function

