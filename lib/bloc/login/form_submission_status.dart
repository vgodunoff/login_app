abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmitionSuccess extends FormSubmissionStatus {}

class SubmitionFailed extends FormSubmissionStatus {
  final Exception exception;

  SubmitionFailed({this.exception});
}
