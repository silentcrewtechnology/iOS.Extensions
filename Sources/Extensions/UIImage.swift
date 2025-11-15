//import ImagesService
import UIKit

public extension UIImage {
    
    /// Текущая иконка по центру поверх иконки-фона
    func centered(
        in backgroundImage: UIImage
    ) -> UIImage {
        let backgroundSize = backgroundImage.size
        let renderer = UIGraphicsImageRenderer(size: backgroundSize)
        let centerAdjustedOrigin = CGPoint(
            x: (backgroundSize.width - size.width) / 2,
            y: (backgroundSize.height - size.height) / 2)
        let image = renderer.image { _ in
            backgroundImage.draw(at: .zero)
            draw(at: centerAdjustedOrigin)
        }
        return image
    }
    
    /// UIImage-круг с цветной заливкой
    static func circle(
        backgroundColor: UIColor,
        diameter: CGFloat
    ) -> UIImage {
        let size = CGSize(width: diameter, height: diameter)
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            backgroundColor.setFill()
            UIBezierPath(ovalIn: .init(origin: .zero, size: size))
                .fill()
        }
        return image
    }

    /// Вместо того, что менять contentMode у
    /// UIImageView на .redraw
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
