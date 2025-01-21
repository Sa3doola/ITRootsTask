//
//  Publisher.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit
import Combine
import CombineSchedulers

typealias Cancellables = Set<AnyCancellable>
typealias Scheduler = AnySchedulerOf<DispatchQueue>
typealias dueTime  = TimeInterval

extension Publisher where Self.Failure == Never {
    
    public func sinkOnMain(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        self
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: receiveValue)
    }
}

extension UIControl {
    func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        return UIControl.EventPublisher(control: self, event: event)
      }
    
    // Publisher
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(control: control, subscrier: subscriber, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
    
    // Subscription
    fileprivate class EventSubscription<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {

        let control: UIControl
        let event: UIControl.Event
        var subscriber: EventSubscriber?
        
        init(control: UIControl, subscrier: EventSubscriber, event: UIControl.Event) {
            self.control = control
            self.subscriber = subscrier
            self.event = event
            
            control.addTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            control.removeTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        @objc func eventDidOccur() {
            _ = subscriber?.receive(control)
        }
    }
}

extension UIButton {
    var time: dueTime{
        return 1.5
    }
    var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .throttle(for: .seconds(time),
                                  scheduler: DispatchQueue.main, latest: false)
    
            .map { _ in }
            .eraseToAnyPublisher()
    }
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        controlPublisher(for: .editingChanged)
            .map { $0 as! UITextField }
            .map { $0.text! }
            .eraseToAnyPublisher()
    }
    
    func createBinding(with subject: CurrentValueSubject<String, Never>, storeIn cancellables: inout Set<AnyCancellable>) {
        subject
            .sink { [weak self] value in
                guard let self = self else { return }
                if value != self.text {
                    self.text = value
                }
            }
            .store(in: &cancellables)
        textPublisher
            .sink { value in
                if value != subject.value {
                    subject.send(value)
                }
            }
            .store(in: &cancellables)
    }
    
    
}

extension UITextView {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextView)?.text }
            .eraseToAnyPublisher()
    }
    
    func createBinding(with subject: CurrentValueSubject<String, Never>, storeIn cancellables: inout Set<AnyCancellable>) {
        subject
            .sink { [weak self] value in
                guard let self = self else { return }
                if value != self.text {
                    self.text = value
                }
            }
            .store(in: &cancellables)
        
        textPublisher
            .sink { value in
                if value != subject.value {
                    subject.send(value)
                }
            }
            .store(in: &cancellables)
    }
}
