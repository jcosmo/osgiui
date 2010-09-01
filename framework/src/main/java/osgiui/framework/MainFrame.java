package osgiui.framework;

import javax.swing.JFrame;
import javax.swing.JLabel;
import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.handlers.jmx.Config;
import org.apache.felix.ipojo.handlers.jmx.Method;

@Config
@Component
public class MainFrame
  extends JFrame
{
  public MainFrame()
  {
    super( "A Frame!" );
    setContentPane( new JLabel( "A label!" ) );
    setDefaultCloseOperation( JFrame.DISPOSE_ON_CLOSE );
    setSize( 640, 480 );
  }

  @Override
  public String getTitle()
  {
    return super.getTitle();
  }
}
