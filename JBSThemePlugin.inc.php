<?php
import('lib.pkp.classes.plugins.ThemePlugin');
class JBSThemePlugin extends ThemePlugin
{
	public function init()
	{
		$this->addStyle('tailwind-css', 'styles/tailwind.min.css', array('contexts' => 'frontend'));
		$this->setParent('defaultthemeplugin');
		$this->addStyle('frontend-css', 'styles/frontend.css', array('contexts' => 'frontend'));
		$this->addStyle('backend-css', 'styles/backend.css', array('contexts' => 'backend'));
	}
	function getDisplayName()
	{
		return 'JBS Child Theme';
	}

	function getDescription()
	{
		return 'This is a child theme for JBS.';
	}
}
