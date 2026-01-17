import UIKit

class MenuViewController: UIViewController {
    
    let tableData: [(section: String,name: [String], rows: [String], portion: [String])] = [
        ("ЧАЙ",
            ["Золотая Юань", "Дикая Вишня","Зелёная Роза","Эрл Грей","Чабрец","Японская Липа","Дарджелинг"],
            ["65","65","65","65","65","65","65"],
            ["0.5","0.5","0.5","0.5","0.5","0.5","0.5"]),
        ("КОФЕ",
            ["Эспрессо","Американо","Американо","Латте"],
            ["70","70","80","80"],
            ["0,2","0,2","0,2","0,2"]),
        ("ДОБАВКИ",
            ["Сахар Порционный","Корица"],
            ["3","1"],
            ["",""]),
        ("ВЫПЕЧКА",
            ["Медовик","Булочка домашняя","Слойка с вишней","Зразы творожные","Пицца большая пепперони","Пицца большая с ветчиной и сыром","Слойка с ветчиной и сыром","Слойка с картофелем и курой","Круассан с бужениной","Круассан с рыбным рийетом","Круассан с ветчиной и сыром"],
            ["65","26","38","89","65","65","35","38","98","75","85"],
            ["","","","","","","","","","",""]),
        ("СЭНДВИЧИ",
            ["Клаб Сэндвич с курицей","Клаб Сэндвич с ветчиной","Сэндвич с ветчиной","Сэндвич с пепперони"],
            ["85","75","75","75"],
            ["","","",""]),
        ("НАПИТКИ",
            ["Вода Бон-Аква","ВИВА ЛИМОН Вода Бон Аква","Фанта Апельсин","Фьюз Лимон","Кока-Кола","Кока-Кола"],
            ["45","50","60","65","29","60"],
            ["0,5","0,5","0,5","0,5","0,25","0,5"])
    ]
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var editProfileButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var menuTableView: UITableView!
    @IBOutlet weak var cartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        PersistanceService.zakazText = ""
        PersistanceService.price = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if PersistanceService.firstEntry != true {
            let registerVC = RegisterViewController()
            present(registerVC,
                    animated: false)
        }
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if PersistanceService.firstEntry != true {
            let registerVC = RegisterViewController()
            present(registerVC,
                    animated: false)
        }
    }
    
    @IBAction func cartButtonPressed(_ sender: UIButton) {
        let contactsVC = ZakazViewController()
        present(contactsVC,
                animated: true)
    }
    
    
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        let registerVC = RegisterViewController()
        present(registerVC,
                animated: false)
    }
    
    
}
extension MenuViewController {
    
    private func configureUI() {
        configureName()
        profileImageView.image = loadImageFromDiskWith(fileName: "avatar")
        let nib = UINib(nibName: ContactsListTableCell.reuseId,
                        bundle: nil)
        menuTableView.register(nib,
                                   forCellReuseIdentifier: ContactsListTableCell.reuseId)
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }
    
    private func configureName() {
        let name = UserDefaults.standard.object(forKey: "name") ?? ""
        nameLabel.text = name as? String
    }

}


extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return tableData[section].1.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfPortionsInSection section: Int) -> Int {
        return tableData[section].portion.count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return tableData[section].section
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsListTableCell.reuseId,
                                                 for: indexPath)
        if let contactCell = cell as? ContactsListTableCell {
            let sectionText = tableData[indexPath.section].name[indexPath.row]
            let rowText = tableData[indexPath.section].portion[indexPath.row]
            let portionText = tableData[indexPath.section].rows[indexPath.row]
            contactCell.updateContent(sectionText: sectionText,
                                      rowText: rowText,
                                      portion: portionText)
        }
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        PersistanceService.zakazText.append(tableData[indexPath.section].name[indexPath.row] + " - " + tableData[indexPath.section].rows[indexPath.row] + "\n")
        PersistanceService.price += Int(tableData[indexPath.section].rows[indexPath.row]) ?? 0
        print(PersistanceService.zakazText)
        print(PersistanceService.price)
        //add to cart
    }
}
