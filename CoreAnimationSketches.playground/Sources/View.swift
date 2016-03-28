import UIKit

public class View: UIView {

    override public init(frame: CGRect) { super.init(frame: frame); setUp() }
    required public init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); setUp() }

    public func setUp() { fatalError("Unimplemented.") }

}
