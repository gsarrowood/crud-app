package com.aquent.crudapp.service;

import java.util.List;

import com.aquent.crudapp.domain.Person;

/**
 * Person operations.
 */
public interface PersonService {

    /**
     * Retrieves all of the person records.
     *
     * @return list of person records
     */
    List<Person> listPeople();

    /**
     * Retrieves all of the person records.
     *
     * @return list of person records
     */
    List<Person> listPeopleForClient( Integer clientId);
	
	/**
	 * syncronizes current persons assigned to this clientId.
	 * i.e. gets original list of all persons belonging to this client now.
	 *      compares selectedPersonIdList against the original list.
	 *      all persons on the original list but not in the selected list will
	 *          be removed (clientId for that person set to -1 (none))
	 *      all persons on the selection list that are NOT on the original
	 *          list will be added (clientId for that person set to clientId).
	 * @param clientId
	 * @param selectedPersonIdList 
	 */
	void syncPeopleForClient( Integer clientId, List<Integer> selectedPersonIdList);
	
    /**
     * Creates a new person record.
     *
     * @param person the values to save
     * @return the new person ID
     */
    Integer createPerson(Person person);

    /**
     * Retrieves a person record by ID.
     *
     * @param id the person ID
     * @return the person record
     */
    Person readPerson(Integer id);

    /**
     * Updates an existing person record.
     *
     * @param person the new values to save
     */
    void updatePerson(Person person);

    /**
     * Deletes a person record by ID.
     *
     * @param id the person ID
     */
    void deletePerson(Integer id);

    /**
     * Validates populated person data.
     *
     * @param person the values to validate
     * @return list of error messages
     */
    List<String> validatePerson(Person person);
}
