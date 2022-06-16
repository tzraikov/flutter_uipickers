class MyPicker: UIView {

    var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tintColor = UIColor.red
        button.setTitleColor(UIColor(red: 0.003, green: 0.478, blue: 1.0, alpha: 1.0), for: .highlighted)
        button.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.937, alpha: 1.0)
        button.layer.cornerRadius = 7
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return button
    }()

    var items: [String] = [] {
        didSet { button.menu = buildMenu() }
    }

    var selectedIndex: Int = -1 {
        didSet {
            button.setTitle(selectedIndex >= 0 ? items[selectedIndex] : "", for: .normal)
            button.menu = buildMenu()
        }
    }

    var onChanged: ((Int)->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leftAnchor.constraint(equalTo: leftAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildMenu() -> UIMenu {
        var actions = [UIAction]()
        var i = 0
        for item in items {
            actions.append(UIAction(
                title: item,
                identifier: .init(rawValue: "\(i)"),
                state: i == selectedIndex ? .on : .off)
            { action in
                self.selectedIndex = Int(action.identifier.rawValue) ?? -1
                self.onChanged?(self.selectedIndex)
            })
            i += 1
        }
        return UIMenu(children: actions)
    }
}
