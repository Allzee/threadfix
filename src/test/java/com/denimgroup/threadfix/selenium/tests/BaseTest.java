////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2009-2011 Denim Group, Ltd.
//
//     The contents of this file are subject to the Mozilla Public License
//     Version 1.1 (the "License"); you may not use this file except in
//     compliance with the License. You may obtain a copy of the License at
//     http://www.mozilla.org/MPL/
//
//     Software distributed under the License is distributed on an "AS IS"
//     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
//     License for the specific language governing rights and limitations
//     under the License.
//
//     The Original Code is Vulnerability Manager.
//
//     The Initial Developer of the Original Code is Denim Group, Ltd.
//     Portions created by Denim Group, Ltd. are Copyright (C)
//     Denim Group, Ltd. All Rights Reserved.
//
//     Contributor(s): Denim Group, Ltd.
//
////////////////////////////////////////////////////////////////////////
package com.denimgroup.threadfix.selenium.tests;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.firefox.FirefoxDriver;

public abstract class BaseTest {
	
	protected final Log log = LogFactory.getLog(this.getClass());
	
	private FirefoxDriver driver;

	@Before
	public void init() {
		driver = new FirefoxDriver();
	}

	@After
	public void shutDown() {
		driver.quit();
	}
	
	public FirefoxDriver getDriver(){
		log.debug("Getting Driver");
		return driver;
	}
	
	/**
	 * This method is a wrapper for RandomStringUtils.random with a preset character set.
	 * @return random string
	 */
	protected String getRandomString(int length) {
		return RandomStringUtils.random(length,"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789");
	}
	
	protected <T> Set<Set<T>> powerSet(T[] items) {
		int count = 1 << items.length;
		
		Set<Set<T>> setOfSets = new HashSet<Set<T>>();
		
		for (int i = 0; i < count; i++) {
			
			Set<T> set = new HashSet<T>();
			int j = 0;
			for (T item : items) {
				if ((i >> j++) % 2 == 1)
					set.add(item);
			}
			
			setOfSets.add(set);
		}
		
		return setOfSets;
	}
}
