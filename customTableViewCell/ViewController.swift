import UIKit
import HGPlaceholders
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var count = 0
    var data = [["row 1"],["row 2"],["row 3"],["row 4"],["row 5"],["row 6"],["row 7"],["row 8"],["row 9"],["row 10"],["row 11"]]
    var sectionTitle = ["section 1","section 2","section 3","section 4","section 5","section 6","section 7","section 8","section 9","section 10","section 11"]
    var table = TableView(frame: .zero, style: .insetGrouped)
    //print("oh")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.showLoadingPlaceholder()
        if !data.isEmpty{
            table.showNoResultsPlaceholder()
            for i in 0...10 {
                for j in 0...10 {
                    data[i].append(" section: \(i) ::: row: \(j)")
                }
            }
            self.table.reloadData()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        header.backgroundColor = .systemTeal
        
        let image = UIImageView(image: UIImage(systemName: "house"))
        image.tintColor = .systemGray5
        image.contentMode = .scaleAspectFit
        header.addSubview(image)
        image.frame = CGRect(x: 5, y: 5, width: header.frame.size.height - 10, height: header.frame.size.height - 10)
       
        
        let label = UILabel(frame: CGRect(x: 10 + image.frame.size.width, y:  5, width: header.frame.size.width - 15 - image.frame.size.width, height: header.frame.size.height - 10))
        header.addSubview(label)
        label.text = "custom Section is: \(sectionTitle[section])"
        label.font = .boldSystemFont(ofSize: 20)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.label.text = data[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        count = count + 1
        print("tapped: \(count)")
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            print("tapped delete ")
        }
        let edit =  UIContextualAction(style: .normal , title: "edit") { _, _, _ in
            print("tapped edit ")
        }
        edit.backgroundColor = .systemBlue
        let swipe  = UISwipeActionsConfiguration(actions: [delete,edit])
        return swipe
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UISwipeActionsConfiguration(actions: [UIContextualAction(style: .normal  , title: "delete", handler: { _, _, _ in
            self.data.remove(at: 5)
            self.table.deleteRows(at: [indexPath], with: .fade)
        })])
        return delete
    }
}

extension ViewController: PlaceholderDelegate {
    
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        print(placeholder.key.value)
        if placeholder.key.value == "loading" {
            print("The placeholder is the Loading screen and Cancel button")
        } else if placeholder.key.value == "noResults" {
            print("The placeholder is the noResults screen and Try Again button")
        } else if placeholder.key.value == "noConnection" {
            print("The placeholder is the noConnection screen and Try Again button")
        } else if placeholder.key.value == "error" {
            print("The placeholder is the error screen and Try Again button")
        }
    }

}

