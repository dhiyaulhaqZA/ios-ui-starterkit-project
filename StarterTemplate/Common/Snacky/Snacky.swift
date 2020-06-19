//
//  Snacky.swift
//  StarterTemplate
//
//  Created by Dhiya Ulhaq Zulha Alamsyah on 25/09/19.
//  Copyright © 2019 dhiyaulhaqza. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
//  OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

/**
 The controller for an `SnackyView`.
 This class handles everything that has to do with showing, dismissing and performing actions in a `SnackyView`.
 There are several static helper methods, which allow presenting a basic snackywithout needing instantiate an `Snacky` yourself.
 */
open class Snacky: Equatable {
    
    // MARK: Public Members
    /// The `SnackyView` for the controller, access this view and it's subviews to do any additional customization.
    open lazy var view: SnackyView = {
        let snackyView = SnackyView(frame: .zero)
        snackyView.controller = self
        snackyView.isHidden = true
        return snackyView
    }()
    
    /**
     The width percent of the total available size that the `view` should take up.
     ## Important
     This should only be a value between `0.0` and `1.0`. If this value is set past this range, the value
     will be reset to the default value of `0.98`.
     */
    open var widthPercent: CGFloat = 0.98 {
        didSet {
            // Clamp at between the range
            if self.widthPercent < 0.0 || self.widthPercent > 1.0 {
                self.widthPercent = 0.98
            }
            self.view.setNeedsLayout()
        }
    }
    
    /**
     The height for the `SnackyView`.
     ## Important
     Do not set the frame of the `view` yourself. Instead set the `widthPercent` and `height`.
     Setting the frame for `view` can have unexpected results as the frame is calculated in a different way depending
     on many variables.
     */
    open var height: CGFloat = 40.0 {
        didSet {
            // Update height
            self.view.setNeedsLayout()
        }
    }
    
    /**
     The bottom spacing for the `view`.
     For example, by default the `view` is placed in the main `UIWindow` of an application with a default
     bottom spacing of `12.0`, however, if you have a `UITabBarController` you may want to increase the bottom spacing
     so that the snacky is presented above the bar.
     */
    open var bottomSpacing: CGFloat = 12.0 {
        didSet {
            // Update frame
            self.view.setNeedsLayout()
        }
    }
    
    /// Similar to the `bottomSpacing` property, except this is only used when multiple `SnackyViews` are stacked.
    open var stackedBottomSpacing: CGFloat = 8.0 {
        didSet {
            // Update any layouts
            self.view.setNeedsLayout()
        }
    }
    
    /**
     Whether or not the Snacky should adjust to fit within the safe area's of it's parent view.
     Only used in iOS 11.0 +
     */
    open var adjustsPositionForSafeArea: Bool = true
    
    /// Optional view to display the `view` in, by default this is `nil`, thus the main `UIWindow` is used for presentation.
    open var viewToDisplayIn: UIView?
    
    /// The duration for the animation of both the adding and removal of the `view`.
    open var animationDuration: TimeInterval = 0.5
    
    /// The completion block for an `Snacky`, `true` is sent if button was tapped, `false` otherwise.
    public typealias SnackyCompletion = (Bool) -> Void
    
    // MARK: Private Members
    /// The timer responsible for notifying about when the view needs to be removed.
    private var displayTimer: Timer?
    
    /// Whether or not the view was initially animated, this is used when animating out the view.
    private var wasAnimated: Bool = false
    
    /// The completion block which is assigned when calling `show(animated:completion:)`
    private var completion: SnackyCompletion?
    
    // MARK: Initializers
    /**
     Creates an `Snacky`.
     ## Important
     If `buttonTitle` is `nil`, no button will be displayed.
     */
    public init (title: String, buttonTitle: String?) {
        // Set labels/buttons
        view.titleLabel.text = title
        
        if let bTitle = buttonTitle {
            view.button.setTitle(bTitle, for: .normal)
        } else {
            // Remove button
            view.button.removeFromSuperview()
        }
        
        // Finish initialization
        finishInit()
    }
    
    /**
     Creates an `Snacky`.
     ## Important
     If `attributedButtonTitle` is `nil`, no button will be displayed.
     */
    public init(attributedTitle: NSAttributedString, attributedButtonTitle: NSAttributedString?) {
        // Set labels/buttons
        view.titleLabel.attributedText = attributedTitle
        
        if let bTitle = attributedButtonTitle {
            view.button.setAttributedTitle(bTitle, for: .normal)
        } else {
            // Remove button
            view.button.removeFromSuperview()
        }
        
        // Finish initialization
        finishInit()
    }
    
    /// Helper method which creates the timer (if needed) and adds the swipe gestures to the view
    private func finishInit() {
        // Add gesture recognizers for swipes
        let left = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        left.direction = .left
        let right = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        right.direction = .right
        let down = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        down.direction = .down
        view.addGestureRecognizer(left)
        view.addGestureRecognizer(right)
        view.addGestureRecognizer(down)
        
        // Register for snacky removal notifications
        NotificationCenter.default.addObserver(self, selector: #selector(self.snackyWasRemoved(notification:)),
                                               name: snackyRemoval, object: nil)
    }
    
    // MARK: Helper Methods
    /// Returns the calculated/appropriate frame for the view, takes into account whether there are multiple snacks on the view.
    internal func frameForView() -> CGRect {
        guard let superview = viewToDisplayIn ?? (UIApplication.shared.windows.first { $0.isKeyWindow }) ?? nil else {
            return .zero
        }
        
        // Set frame for view
        let width: CGFloat = superview.bounds.width * widthPercent
        let startX: CGFloat = (superview.bounds.width - width) / 2.0
        
        let startY: CGFloat
        
        // Check to see if a Snacky is already being presented in this view
        var snackyView: SnackyView?
        for sub in superview.subviews {
            // Loop until we find the last snackyview, since it should be the last one displayed in the superview
            // and the snackyview should be below the current snackyview
            if let snacky = sub as? SnackyView, snacky != view, snacky.frame.maxY > view.frame.maxY {
                snackyView = snacky
            }
        }
        
        // For iOS 11.0 + we can get the safe area of the view, if allowed, we can inset the snackyby this amount in
        // addition to the rest of the insets the user has decided they want
        let safeAreaInset: CGFloat
        if #available(iOS 11.0, *), self.adjustsPositionForSafeArea {
            safeAreaInset = superview.safeAreaInsets.bottom
        } else {
            safeAreaInset = 0
        }
        
        if let snacky = snackyView {
            startY = snacky.frame.maxY - snacky.frame.height - height - stackedBottomSpacing
        } else {
            startY = superview.bounds.maxY - height - bottomSpacing - safeAreaInset
        }
        
        return CGRect(x: startX, y: startY, width: width, height: height)
    }
    
    /// Removes the snackyview from the super view and invalidates any timers.
    private func removeSnacky() {
        view.removeFromSuperview()
        displayTimer?.invalidate()
        displayTimer = nil
    }
    
    // MARK: Animation
    /// Animates the view in using a springy/bounce effect
    private func animateIn() {
        let frame = frameForView()
        let inY = frame.origin.y
        let outY = frame.origin.y + height + bottomSpacing
        // Set up view outside the frame, then animate it back in
        view.isHidden = false
        view.layer.opacity = 0.0
        view.frame = CGRect(x: frame.origin.x, y: outY, width: frame.width, height: frame.height)
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.1,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.0,
            options: .curveEaseInOut,
            animations: {
                // Animate the view to the correct position & opacity
                self.view.layer.opacity = self.view.defaultOpacity
                self.view.frame = CGRect(x: frame.origin.x, y: inY, width: frame.width, height: frame.height)
        },
            completion: nil
        )
        
        wasAnimated = true
    }
    
    /// Animates the view in by moving down towards the edge of the screen and fading it out
    private func animateOut(wasButtonTapped: Bool = false) {
        let frame = view.frame
        let outY = frame.origin.y + height + bottomSpacing
        let pos = CGPoint(x: frame.origin.x, y: outY)
        
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                self.view.frame = CGRect(origin: pos, size: frame.size)
                self.view.layer.opacity = 0.0
        },
            completion: { _ in
                // Call the completion handler
                self.completion?(wasButtonTapped)
                // Remove view
                self.removeSnacky()
        }
        )
    }
    
    /// Animates the swipe of a view by moving it to a specified position
    private func animateSwipeOut(to position: CGPoint) {
        // Invalidate timer
        displayTimer?.invalidate()
        displayTimer = nil
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                // Animate to postion
                self.view.frame = CGRect(origin: position, size: self.view.frame.size)
                self.view.layer.opacity = 0.1
        }, completion: { _ in
            // Call completion handler
            self.completion?(false)
            // Remove view
            self.removeSnacky()
        }
        )
    }
    
    // MARK: Actions
    /// Called whenever the `displayTimer` is done, will animate the view out if allowed
    @objc private func timerDidFinish() {
        if wasAnimated {
            self.animateOut()
        } else {
            // Call the completion handler, since no animation will be shown
            completion?(false)
            // Remove view
            self.removeSnacky()
        }
    }
    
    /// Called whenever the `views`'s button is tapped, will animate the view out if allowed
    internal func viewButtonTapped() {
        // If timer is active, invalidate since view will now dissapear no matter what
        displayTimer?.invalidate()
        displayTimer = nil
        
        if wasAnimated {
            // Animate the view out, which will in turn call the completion handler
            self.animateOut(wasButtonTapped: true)
        } else {
            // Call the completion handler, since no animation will be shown
            completion?(true)
            // Remove snack
            self.removeSnacky()
        }
    }
    
    /// Called when another `SnackyView` was removed from the screen. Refreshes the frame of the current `SnackyView`.
    @objc private func snackyWasRemoved(notification: Notification) {
        // Recalculate the frame, since another snackyview has been removed
        // If this view was on top, it will look weird to have it floating in the same place
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: .curveEaseOut,
            animations: {
                // Update the frame
                self.view.frame = self.frameForView()
        }, completion: nil)
    }
    
    /// Handles left, right, and bottom swipes on the view by animating them out
    @objc private func handleSwipes(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            let position = CGPoint(x: view.frame.origin.x - view.frame.width, y: view.frame.origin.y)
            animateSwipeOut(to: position)
        case .right:
            let position = CGPoint(x: view.frame.origin.x + view.frame.width, y: view.frame.origin.y)
            animateSwipeOut(to: position)
        case .down:
            let position = CGPoint(x: view.frame.origin.x, y: view.frame.origin.y + view.frame.height + bottomSpacing)
            animateSwipeOut(to: position)
        case .up:
            // swiftlint:disable no_fallthrough_only
            fallthrough
        default: break
        }
    }
    
    // MARK: Public Methods
    /**
     Presents the snackyto the screen
     - Parameters:
     - displayDuration: How long to show the snackyfor, if `nil`, will show forever. Default = `5.0`
     - animated: Whether or not the snackyshould animate in and out. Default = `true`
     - completion: The completion handler for when the snackyis removed/button pressed. Default = `nil`
     */
    open func show(displayDuration: TimeInterval? = 5.0, animated: Bool = true, completion: SnackyCompletion? = nil) {
        guard let superview = viewToDisplayIn ?? (UIApplication.shared.windows.first { $0.isKeyWindow }) ?? nil else {
            // swiftlint:disable line_length
            fatalError("Unable to get a superview, was not able to show\n Couldn't add SnackyView as a subview to the main UIWindow")
        }
        
        // Add as subview
        superview.addSubview(self.view)
        
        // Set completion and animate the view if allowed
        self.completion = completion
        
        // Setup timer
        if let duration = displayDuration {
            displayTimer = Timer.scheduledTimer(timeInterval: duration, target: self,
                                                selector: #selector(self.timerDidFinish),
                                                userInfo: nil, repeats: false)
        }
        
        if animated {
            animateIn()
        } else {
            view.isHidden = false
        }
    }
    
    /**
     Allows you to manually dismiss the snackyfrom the screen.
     - `animated`: Whether or not to animate the view out.
     - `completeWithAction`: Whether or not if when dismissing, you want to pass true to the `SnackyCompletion`, which
     means that it will act as if the button was pressed by the user.
     */
    open func dismiss(animated: Bool = true, completeWithAction: Bool = false) {
        guard !completeWithAction else {
            self.viewButtonTapped()
            return
        }
        
        // Invalidate timer
        displayTimer?.invalidate()
        displayTimer = nil
        
        if animated {
            self.animateOut()
        } else {
            // remove the snack
            self.removeSnacky()
        }
    }
    
    // MARK: Static Methods
    /// Allows showing a simple snackywithout needing to instantiate any `Snacky`
    public static func show(view: UIView? = nil, title: String, displayDuration: TimeInterval? = 5.0, completion: SnackyCompletion? = nil) {
        let snacky = Snacky(title: title, buttonTitle: nil)
        snacky.viewToDisplayIn = view
        snacky.show(displayDuration: displayDuration) { _ in
            completion?(false)
        }
    }
    
    /// Allows showing a simple, more customizable, snackywithout needing to instantiate any `Snacky`
    public static func show(attributedTitle: NSAttributedString, displayDuration: TimeInterval? = 5.0, completion: SnackyCompletion? = nil) {
        let snacky = Snacky(attributedTitle: attributedTitle, attributedButtonTitle: nil)
        snacky.show(displayDuration: displayDuration) { _ in
            completion?(false)
        }
    }
    
    // MARK: Equatable
    /// Returns equals if and only if `lhs` and `rhs` are the same object.
    public static func == (lhs: Snacky, rhs: Snacky) -> Bool {
        return lhs === rhs
    }
    
    // MARK: Cleanup
    deinit {
        NotificationCenter.default.removeObserver(self)
        displayTimer?.invalidate()
        displayTimer = nil
        view.controller = nil
        view.removeFromSuperview()
    }
}
