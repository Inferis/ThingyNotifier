//: Playground - noun: a place where people can play

import Cocoa
import Swift

protocol ThingyNotifier : NSObjectProtocol {
    func didDoOneThingy(thingyName: String)
    func didDoOtherThingy(thingyId: Int)
}


class ThingyManager {
    private var notifiers: [ThingyNotifier] = []

    func doOneThingy() {
        for thingyName in ["one-thing", "other-thing"] {
            notifyAll { notifier in
                notifier.didDoOneThingy(thingyName)
            }
        }
    }
    
    func doOtherThingy() {
        for thingyId in [1, 2] {
            notifyAll { notifier in
                notifier.didDoOtherThingy(thingyId)
            }
        }
    }
    
    func addNotifier(notifier: ThingyNotifier) {
        notifiers.append(notifier)
    }
    
    func removeNotifier(notifier: ThingyNotifier) {
        for (var i=0; i<notifiers.count; ++i) {
            if notifiers[i].isEqual(notifier) {
                notifiers.removeAtIndex(i)
                break;
            }
        }
    }
    
    private func notifyAll(notify: ThingyNotifier -> ()) {
        for notifier in notifiers {
            notify(notifier)
        }
    }
}

func +=(left: ThingyManager, right: ThingyNotifier) -> ThingyManager {
    left.addNotifier(right)
    return left
}

func -=(left: ThingyManager, right: ThingyNotifier) -> ThingyManager {
    left.removeNotifier(right)
    return left
}

class N1 : NSObject, ThingyNotifier {
    func didDoOneThingy(thingyName: String) {
        println("thingyName=\(thingyName)")
    }
    
    func didDoOtherThingy(thingyId: Int) {
        println("thingyId=\(thingyId)")
    }
}

class N2 : NSObject, ThingyNotifier {
    func didDoOneThingy(thingyName: String) {
        println("WOW thingyName=\(thingyName)")
    }
    
    func didDoOtherThingy(thingyId: Int) {
        println("WOW thingyId=\(thingyId)")
    }
}

var mgr = ThingyManager()
var n1 = N1()
var n2 = N2()
mgr += n1
mgr += n2
mgr.doOneThingy()
mgr -= n1
mgr.doOneThingy()
