Imports Telerik.Web.UI
Imports System.Data
Imports System.Data.SqlClient
Imports System
Imports System.IO
Imports System.Security.Cryptography
Imports System.Text
Imports System.Collections
Imports System.Net.Mail
Imports System.Net

Public Class Model
    Private ReadOnly connectionString As String = "Data Source=ZAID-QASIM;Initial Catalog=milahow_Space_Optimizer;Integrated Security=True"
    'Private ReadOnly connectionString As String = "Data Source=sql.bsite.net\MSSQL2016;Initial Catalog=milahow_Space_Optimizer;User Id=milahow_Space_Optimizer;Password=watrf107milahow;"

    Private ReadOnly connection As SqlConnection
    Private ReadOnly key As String = "0123456789ABCDEF"
    Private ReadOnly iv As String = "0123456789ABCDEF"
    Dim senderEmail As String = "zaidqasim1234+SpaceOptimzer@gmail.com"

    Public Sub New()
        If connection Is Nothing Then
            connection = New SqlConnection(connectionString)
            Try
                connection.Open()
            Catch ex As Exception

            End Try
        End If
    End Sub

    Public Function ExecuteSP(StoredProc As String, values As Hashtable) As DataSet
        Dim ds As New DataSet
        Dim dataAdatpter As SqlDataAdapter
        Dim command As New SqlCommand
        command.Connection = connection
        command.CommandTimeout = 3600
        command.CommandType = CommandType.StoredProcedure
        command.CommandText = StoredProc

        ' Add parameters using the foreach loop
        For Each key As Object In values.Keys
            command.Parameters.AddWithValue("@P_" + key.ToString(), values(key).ToString())
        Next

        Try
            dataAdatpter = New SqlDataAdapter(command)
            dataAdatpter.Fill(ds)
        Catch ex As Exception
            Dim e = ex
        End Try

        Return ds
    End Function

    Public Sub FillCombo(dt As DataTable, ByRef combo As RadComboBox)
        For Each row As DataRow In dt.Rows
            combo.Items.Add(New RadComboBoxItem(row(1), row(0)))
        Next
    End Sub

    Public Function Encrypt(dataToEncrypt As String) As String
        ' Convert the key and IV to byte arrays
        Dim keyBytes As Byte() = Encoding.UTF8.GetBytes(key)
        Dim ivBytes As Byte() = Encoding.UTF8.GetBytes(iv)

        Using aesAlg As New AesCryptoServiceProvider()
            aesAlg.Key = keyBytes
            aesAlg.IV = ivBytes

            ' Create an encryptor to perform the stream transform.
            Dim encryptor As ICryptoTransform = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV)

            ' Create the streams used for encryption.
            Using msEncrypt As New MemoryStream()
                Using csEncrypt As New CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write)
                    Using swEncrypt As New StreamWriter(csEncrypt)
                        'Write all data to the stream.
                        swEncrypt.Write(dataToEncrypt)
                    End Using
                End Using
                Return Convert.ToBase64String(msEncrypt.ToArray())
            End Using
        End Using
    End Function

    Public Function Decrypt(encryptedData As String) As String
        ' Convert the key and IV to byte arrays
        Dim keyBytes As Byte() = Encoding.UTF8.GetBytes(key)
        Dim ivBytes As Byte() = Encoding.UTF8.GetBytes(iv)

        Using aesAlg As New AesCryptoServiceProvider()
            aesAlg.Key = keyBytes
            aesAlg.IV = ivBytes

            ' Create a decryptor to perform the stream transform.
            Dim decryptor As ICryptoTransform = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV)

            ' Create the streams used for decryption.
            Using msDecrypt As New MemoryStream(Convert.FromBase64String(encryptedData))
                Using csDecrypt As New CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read)
                    Using srDecrypt As New StreamReader(csDecrypt)
                        ' Read the decrypted bytes from the decrypting stream and place them in a string.
                        Return srDecrypt.ReadToEnd()
                    End Using
                End Using
            End Using
        End Using
    End Function

    Public Function EmailConfig(OTP As String, UserName As String, Type As String) As Tuple(Of String, String)
        Dim SignUpSubject As String = "Your SpaceOptimizer - Confirmation Code: " & OTP
        Dim SignUpBody As String = "
        <html>
			<body>
				<p>
					Dear " + UserName + ",
				</p>
				<p>Thank you for choosing SpaceOptimizer to enhance your space management experience! 
					We are excited to inform you that your purchase has been successfully processed. Below is 
					your confirmation code:
				</p>
				<p>
					Confirmation Code: <b>" + OTP + "</b>
				</p>
				<p>
					To complete the confirmation process and access your SpaceOptimizer account, please click on 
					the following link: 
					<a href='http://localhost:61629/Pages/Login.aspx'>
						Login Page
					</a>.
				</p>
				<p>
					Please keep this code handy for any future reference or inquiries related to your purchase. 
					If you have any questions or concerns, feel free to reply to this email or contact our 
					customer support team at 
					<a href='mailto:zaidqasim1234+SpaceOptimizer+Support@gmail.com'>
						Support_SpaceOptimizer@gmail.com
					</a>.
				</p>
				<p>
					We appreciate your trust in SpaceOptimizer and hope our product adds value to your space 
					optimization needs. Enjoy exploring the full potential of your space with SpaceOptimizer!
				</p>
				<p>
					Best regards,
				</p>
				<p>
					Admin <br>Space Optimizer Customer Support
				</p>
			</body>
			</html>"
        Dim ResetSubject As String = "Your SpaceOptimizer - Reset Code: " & OTP
        Dim ResetBody As String = "
        <html>
			<body>
				<p>
					Dear " + UserName + ",
				</p>
				<p>
					It seems like you''ve forgotten your SpaceOptimizer password. No worries – we''re here to 
					help! To reset your password and regain access to your account, please click on the 
					following link: <b>" + OTP + "</b>
				</p>
				<p>
					If you did not request a password reset, please ignore this email.
				</p>
				<p>
					If you encounter any issues or need further assistance, feel free to reply to this email 
					or contact our customer support team at 
					<a href='mailto:zaidqasim1234+SpaceOptimizer+Support@gmail.com'>
						Support_SpaceOptimizer@gmail.com
					</a>.
				</p>
				<p>
					Thank you for choosing SpaceOptimizer. We''re dedicated to providing you with the best 
					space optimization experience, and we''re here to assist you every step of the way.
				</p>
				<p>
					Best regards,
				</p>
				<p>
					Admin <br>Space Optimizer Customer Support
				</p>
			</body>
			</html>"
        If Type = "signup" Then
            Return Tuple.Create(SignUpSubject, SignUpBody)
        ElseIf Type = "reset" Then
            Return Tuple.Create(ResetSubject, ResetBody)
        Else
            ' Handle other cases or return default values
            Return Tuple.Create("", "")
        End If
    End Function

    Public Sub SendEmail(UserName As String, Type As String, otp As String)
        Dim recipientEmail As String = "zaidqasim1234@gmail.com"
        Dim ht As New Hashtable
        ht.Add("UserName", UserName)
        Dim email = EmailConfig(OTP, UserName, Type)
        Dim mail As New MailMessage(senderEmail, recipientEmail, email.Item1, email.Item2)
        mail.IsBodyHtml = True
        Dim smtpClient As New SmtpClient("smtp.gmail.com")
        smtpClient.Port = 587
        smtpClient.Credentials = New NetworkCredential("zaidqasim1234@gmail.com", "zzurvxmvphkqxaxu")
        smtpClient.EnableSsl = True
        Try
            smtpClient.Send(mail)
            Console.WriteLine("Email sent successfully!")
        Catch ex As Exception
            Console.WriteLine("Error sending email: " & ex.Message)
        End Try
    End Sub
End Class
