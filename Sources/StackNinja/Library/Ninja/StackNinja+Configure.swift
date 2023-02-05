//
//  File.swift
//
//
//  Created by Aleksandr Solovyev on 09.08.2022.
//

import ReactiveWorks
import UIKit

public extension StackNinja
{
   func configure<M>() where S == SComboM<M>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
   }

   // right

   // M R _
   // _ _ _
   // _ _ _
   func configure<M, R>() where S == SComboMR<M, R>
   {
      configureRightStart()
      view.addArrangedSubview(models.main.uiView)
      view.addArrangedSubview(models.right.uiView)
   }

   // M R R
   // _ _ _
   // _ _ _
   func configure<M, R, R2>() where S == SComboMRR<M, R, R2>
   {
      configureRightStart()
      view.addArrangedSubview(models.main.uiView)
      view.addArrangedSubview(models.right.uiView)
      view.addArrangedSubview(models.right2.uiView)
   }

   // M R R R
   // _ _ _ _
   // _ _ _ _
   func configure<M, R, R2, R3>() where S == SComboMRRR<M, R, R2, R3>
   {
      configureRightStart()
      view.addArrangedSubview(models.main.uiView)
      view.addArrangedSubview(models.right.uiView)
      view.addArrangedSubview(models.right2.uiView)
      view.addArrangedSubview(models.right3.uiView)
   }

   // M R _
   // _ D _
   // _ _ _
   func configure<M, R, D>() where S == SComboMRD<M, R, D>
   {
      configureRightStart()
      view.addArrangedSubview(models.main.uiView)
      let vert = vertical
      vert.addArrangedSubview(models.right.uiView)
      vert.addArrangedSubview(models.down.uiView)
      view.addArrangedSubview(vert)
   }

   // M R R
   // _ _ D
   // _ _ _
   func configure<M, R, R2, D>() where S == SComboMRRD<M, R, R2, D>
   {
      configureRightStart()
      view.addArrangedSubview(models.main.uiView)
      view.addArrangedSubview(models.right.uiView)
      let vert = vertical
      vert.addArrangedSubview(models.right2.uiView)
      vert.addArrangedSubview(models.down.uiView)
      view.addArrangedSubview(vert)
   }

   // M R R
   // _ D _
   // _ _ _
   func configure<M, R, D, R2>() where S == SComboMRDR<M, R, D, R2>
   {
      configureRightStart()
      view.addArrangedSubview(models.main.uiView)
      let vert = vertical
      vert.addArrangedSubview(models.right.uiView)
      vert.addArrangedSubview(models.down.uiView)
      view.addArrangedSubview(vert)
      view.addArrangedSubview(models.right2.uiView)
   }

   // M R _
   // _ D _
   // _ D _
   func configure<M, R, D, D2>() where S == SComboMRDD<M, R, D, D2>
   {
      configureRightStart()
      view.addArrangedSubview(models.main.uiView)
      let vert = vertical
      vert.addArrangedSubview(models.right.uiView)
      vert.addArrangedSubview(models.down.uiView)
      vert.addArrangedSubview(models.down2.uiView)
      view.addArrangedSubview(vert)
   }

   // down

   // M _ _
   // D _ _
   // _ _ _
   func configure<M, D>() where S == SComboMD<M, D>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
      view.addArrangedSubview(models.down.uiView)
   }

   // M _ _
   // D R _
   // _ _ _
   func configure<M, D, R>() where S == SComboMDR<M, D, R>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
      let horz = horizontal
      horz.addArrangedSubview(models.down.uiView)
      horz.addArrangedSubview(models.right.uiView)
      view.addArrangedSubview(horz)
   }

   // M _ _
   // D _ _
   // D _ _
   func configure<M, D, D2>() where S == SComboMDD<M, D, D2>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
      view.addArrangedSubview(models.down.uiView)
      view.addArrangedSubview(models.down2.uiView)
   }

   // M _ _
   // D _ _
   // D R _
   func configure<M, D, D2, R>() where S == SComboMDDR<M, D, D2, R>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
      view.addArrangedSubview(models.down.uiView)
      let horz = horizontal
      horz.addArrangedSubview(models.down2.uiView)
      horz.addArrangedSubview(models.right.uiView)
      view.addArrangedSubview(horz)
   }

   // M _ _
   // D R _
   // D _ _
   func configure<M, D, R, D2>() where S == SComboMDRD<M, D, R, D2>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
      let horz = horizontal
      horz.addArrangedSubview(models.down.uiView)
      horz.addArrangedSubview(models.right.uiView)
      view.addArrangedSubview(horz)
      view.addArrangedSubview(models.down2.uiView)
   }

   // M _ _
   // D R _
   // D _ _
   // D _ _
   func configure<M, D, R, D2, D3>() where S == SComboMDRDD<M, D, R, D2, D3>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
      let horz = horizontal
      horz.addArrangedSubview(models.down.uiView)
      horz.addArrangedSubview(models.right.uiView)
      view.addArrangedSubview(horz)
      view.addArrangedSubview(models.down2.uiView)
      view.addArrangedSubview(models.down3.uiView)
   }

   // M _ _
   // D R R
   // _ _ _
   func configure<M, D, R, R2>() where S == SComboMDRR<M, D, R, R2>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
      let horz = horizontal
      horz.addArrangedSubview(models.down.uiView)
      horz.addArrangedSubview(models.right.uiView)
      horz.addArrangedSubview(models.right2.uiView)
      view.addArrangedSubview(horz)
   }

   // M _ _
   // D _ _
   // D _ _
   // D _ _
   func configure<M, D, D2, D3>() where S == SComboMDDD<M, D, D2, D3>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
      view.addArrangedSubview(models.down.uiView)
      view.addArrangedSubview(models.down2.uiView)
      view.addArrangedSubview(models.down3.uiView)
   }
   
   // M _ _
   // D _ _
   // D _ _
   // D _ _
   // D _ _
   func configure<M, D, D2, D3, D4>() where S == SComboMDDDD<M, D, D2, D3, D4>
   {
      configureDownStart()
      view.addArrangedSubview(models.main.uiView)
      view.addArrangedSubview(models.down.uiView)
      view.addArrangedSubview(models.down2.uiView)
      view.addArrangedSubview(models.down3.uiView)
      view.addArrangedSubview(models.down4.uiView)
   }

   // M R _
   // LD_ _
   // _ _ _
   func configure<M, R, LD>() where S == SComboMRLD<M, R, LD>
   {
      configureDownStart()
      let horz = horizontal
      horz.addArrangedSubview(models.main.uiView)
      horz.addArrangedSubview(models.right.uiView)
      view.addArrangedSubviews(horz)
      view.addArrangedSubview(models.leftDown.uiView)
   }
}

private extension StackNinja
{
   func configureRightStart()
   {
      clear()
      view.axis = .horizontal
   }

   func configureDownStart()
   {
      clear()
      view.axis = .vertical
   }

   private func clear()
   {
      view.subviews.forEach { $0.removeFromSuperview() }
   }

   // makers
   var vertical: StackViewExtended
   {
      let stack = StackViewExtended()
      stack.axis = .vertical
      return stack
   }

   var horizontal: StackViewExtended
   {
      let stack = StackViewExtended()
      stack.axis = .horizontal
      return stack
   }
}
