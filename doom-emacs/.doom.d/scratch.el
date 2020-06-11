Error.t = FetchingDomicileError
;;
BioData.t = {
email: Option | Error(msg) | Valid(email)
...
}
;;
InquiringBioData.t =
{
data: BioData.t
error: Error.t
}
;;
InquiringJobDataData.t = {
jobData: JobData.t
bioData: BioData.t
activeStep: 0
}
;;
InquiringJobData.t =
{
data: InquiringJobDataData.t
error: Error.t
}
;;
Interactive.t =
| InquiringBioData      ;; biodata
| InquiringJobData      ;; biodata + jobdata
| InquiringConfirmation ;; biodata + jobdata + confirmation
;;
Interactive
(Interactive.t)
;;
Initial
FetchingDomicile
Interactive()
SubmittingData
DataSubmitted

ActiveStep.t =
| InquiringBioData
| InquiringJobData
| InquiringConfirmation

State =
| Initial
| InquiringData = {
jobData: Option(JobData.t)
bioData: Option(BioData.t)
confirmationData: Option(ConfirmationData.t)
activeStep: ActiveStep.t
error: Error.t
}
| SubmittingData
| SuccessfullySubmitData
