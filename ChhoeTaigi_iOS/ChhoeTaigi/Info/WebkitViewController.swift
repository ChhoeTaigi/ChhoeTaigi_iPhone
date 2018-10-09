
import UIKit
import WebKit

class WebkitViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    public var linkAddress: String?
    
    private var webView: WKWebView!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let webConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
        self.view.addSubview(webView)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.frame = view.frame;
        
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style = UIActivityIndicatorView.Style.gray
        
        self.view.addSubview(activityIndicator)
        showActivityIndicator(show: true)
        
        let url = URL(string: linkAddress!)!
        self.webView.load(URLRequest(url: url))
        self.webView.allowsBackForwardNavigationGestures = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
