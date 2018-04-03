

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {


    private var lastSeguedToVC : ConcentrationViewController?
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        if lastSeguedToVC == nil {
            return true
        }
        return false
        
    }
    
    
    
    
    @IBAction func chooseAnimals(_ sender: Any) {
        
        if let cvc = lastSeguedToVC {   // if there was a saved VC went back from
            if let theme = (sender as? UIButton)?.currentTitle {
                cvc.theme = theme
                navigationController?.pushViewController(cvc, animated: true)
            }
        } else {    // no saved VC, so create new one
            performSegue(withIdentifier: "Choose Theme",sender: sender)
        }
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
                if let theme = (sender as? UIButton)?.currentTitle {
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.theme = theme
                        lastSeguedToVC = cvc
                    }
                }
            }
    }


}
