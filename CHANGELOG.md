# CHANGELOG
The changelog for **Toasted**.

# Upcoming release

### Added
- **Toast**
  - Defines and encapsulates all the standard behavior of toast UI elements.
  - Show the `Toast` in a UIView.
  - Show the `Toast` in the application's UIWindow.
  - After a given period of time automatically hides the toast.
  - Hide the toast manually.
  - Setting the duration property to 0 prevents the toast from being faded.
- **ToastView**
  - Holds information and responsible for the UI look and feel.
- **BasicToastView**
  - A basic `ToastView` with a title. This is the standard use of Toasts.
- **Toasted**
  - Contains only constants for `Toast` or `ToastView`.
- **TutorialListController**
  - List of possible examples. Currently has only one.
- **TutorialBasicController**
  - Simple usage example for displaying two different toast even at the same time.
  - Usage example for showing a `Toast` in the UIWindow no matter what controller we are in.
- **MockService**
  - An example of service that can be used for Demo purposes and testing.
- **ToastConfiguration**
  - This object has all the properties you can use to custome your `Toast`.
  - Configurable parameters: duration, textColor, backgroundColor, textAlignment and font.

### Changed

### Fixed

### Removed

### Deprecated
